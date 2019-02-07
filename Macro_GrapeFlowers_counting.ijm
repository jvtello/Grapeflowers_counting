path=getDirectory("image"); 
list=getFileList(path); 
for(i=0;i<list.length;i++){ 
open(path+list[i]); 

fileName = getTitle();
run("Invert");
run("Subtract Background...", "rolling=1 light disable");
run("Duplicate...", "title=temp");
run("Duplicate...", "title=temp2");
selectWindow("temp");
run("Apply saved SIOX segmentator", "siox=[DIR/Segmentator_GrapeFlowers_counting.siox]"); //Replace DIR for Segmentator_GrapeFlowers_counting.siox directory 
wait(2000);
selectWindow("temp2");
close("temp");
wait(1000);
run("8-bit");
wait(1000);
run("Morphological Segmentation");
wait(1000);
selectWindow("Morphological Segmentation");
wait(1000);
call("inra.ijpb.plugins.MorphologicalSegmentation.setInputImageType", "object");
wait(500);
call("inra.ijpb.plugins.MorphologicalSegmentation.setGradientRadius", "8");
wait(500);
call("inra.ijpb.plugins.MorphologicalSegmentation.segment", "tolerance=8", "calculateDams=true", "connectivity=8");
wait(500);
call("inra.ijpb.plugins.MorphologicalSegmentation.setDisplayFormat", "Watershed lines");
wait(20000);
selectWindow("Morphological Segmentation");
wait(500);
call("inra.ijpb.plugins.MorphologicalSegmentation.createResultImage");
wait(25000);
close("temp2");
wait(500);
selectWindow("temp2-watershed-lines");
wait(100);
run("Dilate");
wait(100);
run("Dilate");
wait(100);
run("Invert");
wait(100);
imageCalculator("Add create", "Segmented stack","temp2-watershed-lines");
selectWindow("Result of Segmented stack");
run("Analyze Particles...", "size=500-10000 circularity=0.50-1.00 show=[Overlay Masks] display exclude clear summarize add in_situ"); //ranges should be adapted to user needs
wait(1000);
saveAs("Jpeg", "DIR2" + fileName + "_results.jpg"); //Replace DIR2 for output directory
wait(1000);
run("Close All");
wait(500);
}