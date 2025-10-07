module Compiler
  module_function

  unless defined?(sign_main)
    class << Compiler
      alias sign_main main
    end
  end

  def main
    sign_main
    pbLoadSignComments
  end

  def pbLoadSignComments(verbose = false)
    mapdata = MapData.new
    t = Time.now.to_i
    Graphics.update
    $Signs = []
    for id in mapdata.mapinfos.keys.sort
      $Signs[id] = []
      map=mapdata.getMap(id)
      next if !map || !mapdata.mapinfos[id]
      if verbose
        echoln _INTL("Processing proximity signs on map {1} ({2})",id,mapdata.mapinfos[id].name)
      end
      for key in map.events.keys
        if Time.now.to_i - t >= 5
          Graphics.update
          t = Time.now.to_i
        end
        pbLoadSignsFromEvent(map.events[key],$Signs[id])
      end
    end
    Graphics.update
  end

  def pbLoadSignsFromEvent(event, signs)
    return if !event || event.pages.length==0
    for page in 0...event.pages.length
      commands=[]
      list=event.pages[page].list
      i=0; while i<list.length
        if list[i].code==108
          command=list[i].parameters[0]
          j=i+1; while j<list.length
            break if list[j].code!=408
            command+="\r\n"+list[j].parameters[0]
            j+=1
          end
          if command[/^(Sign\:|SignTop\:|SignUp\:|SignLeft\:|SignRight\:|SignBottom\:)/i]
            commands.push(command)
          end
        end
        i+=1
      end
      next if commands.length==0
      for command in commands
        cmd = command[0...(command.index(":"))]
        text = command[(command.index(":")+1)..command.length]
        text.strip!
        direction = :top
        case cmd
        when "Sign", "SignTop", "SignUp"
          direction = :top
        when "SignBottom"
          direction = :bottom
        when "SignLeft"
          direction = :left
        when "SignRight"
          direction = :right
        end
        signs.push([event.id,page,direction,text])
      end
    end
  end
end
