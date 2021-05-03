//
//  GiffyImageItem.swift
//  LivelikeSample
//
//  Created by Shahid Ali on 4/12/21.
//



struct GiffyImageItem:Codable {
	var original:Original?
	
}


struct Original:Codable
{
	var height:String?
	var width:String?
	var size:String?
	var url:String?
	var mp4_size:String?
	var mp4:String?
	var webp_size:String?
	var webp:String?
	var frames:String?
	var hash:String?
}
