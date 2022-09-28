
fileID = mopen('G04-d-11_5439-jgd.xml','r');

j = 1;


//巨大になりすぎて処理できないので、3次メッシュだけ
while ~meof(fileID)
    tline = mgetl(fileID,1);
    if strindex(tline,'<gml:tupleList>') > 0
      //for i = 1:16
      i = 1;
        tline = mgetl(fileID,1);
        C = strsplit(tline,',');
        meshcode(j) = C(1);
        elevation(j) = strtod(C(2));
        j = j + 1;
      //end
    end
end

mclose(fileID);



gain_lat(3) = 30 / 3600;
gain_lat(2) = gain_lat(3) * 10;
gain_lat(1) = 1.5;

gain_lng(3) = 45 / 3600;
gain_lng(2) = gain_lng(3) * 10;
gain_lng(1) = 100;//これは足すだけ

for i = 1:size(meshcode,'r')
	mesh_lat(1) = strtod(part(meshcode(i),1:2));
	mesh_lng(1) = strtod(part(meshcode(i),3:4));
	mesh_lat(2) = strtod(part(meshcode(i),5));
	mesh_lng(2) = strtod(part(meshcode(i),6));
	mesh_lat(3) = strtod(part(meshcode(i),7));
	mesh_lng(3) = strtod(part(meshcode(i),8));

	lat(i) = mesh_lat(1) / gain_lat(1) + mesh_lat(2) * gain_lat(2) + mesh_lat(3) * gain_lat(3);
	lng(i) = mesh_lng(1) + gain_lng(1) + mesh_lng(2) * gain_lng(2) + mesh_lng(3) * gain_lng(3);
	
	y = mesh_lat(2) * 10 + mesh_lat(3) + 1;
	x = mesh_lng(2) * 10 + mesh_lng(3) + 1;
	
	T(x,y) = elevation(i);
	label_lat(y) = lat(i);
	label_lng(x) = lng(i);

end

//plot(lng,lat);
//scf();

grayplot(label_lng,label_lat,T);

zm = min(elevation);
zM = max(elevation);
colorbar(zm,zM);

//市町村ポリゴンを表示
geodata = fromJSON("N03-19_09_190101.geojson","file");

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

