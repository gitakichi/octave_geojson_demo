geodata = fromJSON("N03-19_09_190101.geojson","file");


//figure
//hold on

i = 1;
outline = geodata.features(i).geometry.coordinates;

if type(outline) == 15
  for j = 1:length(outline)
    lng = outline(j)(:,1);
    lat = outline(j)(:,2);
    plot(lng,lat,'Color',[0 0 0],'LineWidth',3);
    //fill(lng,lat,'y');
  end
else
  lng = outline(:,1);
  lat = outline(:,2);
  plot(lng,lat,'Color',[0 0 0],'LineWidth',3);
  //fill(lng,lat,'y');
end

for i = 2:length(geodata.features)
  outline = geodata.features(i).geometry.coordinates;

  //disp(length(outline));
  //disp(type(outline));
	
  if type(outline) == 15
    for j = 1:length(outline)
      lng = outline(j)(:,1);
      lat = outline(j)(:,2);
      plot(lng,lat);
      //fill(lng,lat,'w');
    end
  else
    lng = outline(:,1);
    lat = outline(:,2);
    plot(lng,lat);
    //fill(lng,lat,'w');
  end
end



/*
%tochigi pref office
%DMS(Degree Minute Second) format
%139°53′01″
%36°33′57″
dms_lng = [139,53,01];
dms_lat = [36,33,57];
deg_lng = dms_lng(1) + dms_lng(2)/60 + dms_lng(3)/3600;
deg_lat = dms_lat(1) + dms_lat(2)/60 + dms_lat(3)/3600;
plot(deg_lng,deg_lat,'o');


hold off

%kanuma city office
%139°44′42″
%36°34′02″
%dms_lng = [139,44,42];%kanuma
%dms_lat = [36,34,02];%kanuma
%deg_lng = dms_lng(1) + dms_lng(2)/60 + dms_lng(3)/3600;
%deg_lat = dms_lat(1) + dms_lat(2)/60 + dms_lat(3)/3600;

target_lng = deg_lng;
target_lat = deg_lat;

outline = geodata.features(1).geometry.coordinates;
utsunomiya_lng = outline(:,1);
utsunomiya_lat = outline(:,2);

in_utsunomiya = inpolygon(target_lng,target_lat,utsunomiya_lng,utsunomiya_lat);
disp(in_utsunomiya);
*/



