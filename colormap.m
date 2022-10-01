//GMLからデータを取り出す
[meshcode1,elevation1] = get_elevation('G04-d-11_5439-jgd.xml');
[meshcode2,elevation2] = get_elevation('G04-d-11_5440-jgd.xml');
[meshcode3,elevation3] = get_elevation('G04-d-11_5539-jgd.xml');
[meshcode4,elevation4] = get_elevation('G04-d-11_5540-jgd.xml');

//GMLから取り出したデータをマージする
meshcode = [meshcode1;meshcode2;meshcode3;meshcode4];
elevation = [elevation1;elevation2;elevation3;elevation4];

//マージしたデータを表示する
elevation_matrix(meshcode,elevation);

