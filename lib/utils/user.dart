class User {
  final String id;
  final String name;
   final String type;
   final String phone;
  final String email;
  
 
  final String avatar;
  final String email_verified_at;
  final String created_at;
   final String updated_at;
    final String token;

 

 User(this.id,this.name,this.type,this.phone,this.email,this.avatar,this.email_verified_at,this.created_at,this.updated_at,this.token);

  
}

class  Post_search {
  final int id;
  Post_search(this.id);
  
}
class building{
  final String id;
  final String title;
  final String category_id;
  final String subcategory_id;
  final String user_id;
  final String approved;
  final String hash;
  final String price;
  final String country;
  final String governorate;
  final String region;
  final String address;
  final String area;
  final String has_parking;
  final String rooms_number;
  final String floors_number;
  final String construction_year;
  final String lat_lng;
  final String notes;
  final String extra;
  final String created_at;
  final String updated_at;
  final String image;
  final List<String> files;
  final String avatar;
  final String name;
  final int favorite;
  
  final String phone;
  building(this.id,this.title,this.category_id,this.subcategory_id,this.user_id,this.approved,this.hash
  ,this.price,this.country,this.governorate,this.region,this.address,this.area,this.has_parking,this.rooms_number,
  this.floors_number,this.construction_year,this.lat_lng,this.notes,this.extra,this.created_at,
  this.updated_at,this.image,this.files,this.phone,this.avatar,this.name, this.favorite
  );
  

  
   

  
  
}
