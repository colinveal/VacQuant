//Macro for ImajeJ to use machine learning to automatically measure the are of vacuolation in drosophila brain tissue
//open first image
Table.create("Results");
bfile=getFileList("/insert file path to cropped images");
for(i=0;i<bfile.length;i++){
//for(i=0;i<2;i++){
//open("image file path");
open("/image file path"+bfile[i]);
//open plugin
run("Trainable Weka Segmentation");
//selectWindow("Trainable Weka Segmentation v3.2.34");
//load classifier and data
wait(4000);
call("trainableSegmentation.Weka_Segmentation.loadClassifier", "/insert file path to classifier");
wait(4000);
call("trainableSegmentation.Weka_Segmentation.loadData", "/insert file path to data");
wait(4000);
//training classifier and creating result
call("trainableSegmentation.Weka_Segmentation.trainClassifier");
call("trainableSegmentation.Weka_Segmentation.getResult");
wait(10000);
selectImage("Classified image");
outfile = split(bfile[i],".");
saveAs("tiff","/insert file path to folder to save final images"+outfile[0]+"_classified.tif");
wait(10000);
//obtaining histogram and saving results
//run("Histogram");
getHistogram(values, counts, 256);
//Table creation and saving
Table.set("Image",i,bfile[i]);
Table.set("brain",i,counts[0]);
Table.set("Vacuole",i,counts[1]);
Table.set("bg",i,counts[2]);
Table.set("percentV",i,(counts[1]/counts[0])*100);

close("*");
run("Collect Garbage");
wait(10000);
}
//Table.setColumn("Values", values); //Column with histogram values
//Table.setColumn("Counts", counts); //Column with histogram counts
selectWindow("Results");
saveAs("results", "/insert file path to final image folder/ClassifiedPixelCounts.csv");
