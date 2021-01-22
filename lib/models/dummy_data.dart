import './user_crop.dart';
import './timeline_model.dart';

var dummyCrop =  [
  UserCrop(
    id: 'uc1',
    name: 'Wheat',
    variety: 'GW-503',
    taluka: 'Manavadar',
    district: 'Junagadh',
    state: 'Gujarat',
    date: DateTime.parse("2020-07-20 20:18:04Z"),
    area: 10,    
  ),
  UserCrop(
    id: 'uc2',
    name: 'Ground Nut',
    variety: 'G-20',
    taluka: 'Keshod',
    district: 'Junagadh',
    state: 'Gujarat',
    date: DateTime.parse("2020-12-15 20:18:04Z"),
    area: 15,    
  ),
  UserCrop(
    id: 'uc3',
    name: 'Corn',
    variety: 'Hybrid-21',
    taluka: 'Manavadar',
    district: 'Junagadh',
    state: 'Gujarat',
    date: DateTime.parse("2020-11-10 20:18:04Z"),
    area: 5,    
  )
];
var dummyTimeline = [
  TimelineModel(
    id: 't1',
    usercropid: 'uc1',
    title: 'Seeds sowing',
    description: 'I sowed wheat of variety GW-503. It cost me around 40Rs/kg. It was nice quality seeds.',
    date: DateTime.parse("2020-07-21 20:18:04Z"),
  ),
  TimelineModel(
    id: 't2',
    usercropid: 'uc1',
    title: 'Watering',
    description: 'I watred crop after 2 days',
    date: DateTime.parse("2020-07-23 20:18:04Z"),
  ),
  TimelineModel(
    id: 't3',
    usercropid: 'uc1',
    title: 'Fertilizer',
    description: 'Used urea 5kg/1vigha. Cost me 700per/20kg',
    date: DateTime.parse("2020-07-25 20:18:04Z"),
  ),
  TimelineModel(
    id: 't4',
    usercropid: 'uc1',
    title: 'Watering',    
    date: DateTime.parse("2020-07-25 20:18:04Z"),
  ),
  TimelineModel(
    id: 't5',
    usercropid: 'uc1',
    title: 'Plant height 5cm',    
    date: DateTime.parse("2020-07-27 20:18:04Z"),
  ),
  TimelineModel(
    id: 't6',
    usercropid: 'uc1',
    title: 'Added Fertilzer',    
    description: 'Used NPK 1kg per 1vigha',
    date: DateTime.parse("2020-07-29 20:18:04Z"),
  ),
  TimelineModel(
    id: 't7',
    usercropid: 'uc1',
    title: 'Harvesting',
    description: 'I sowed wheat of variety GW-503. It cost me around 40Rs/kg. It was nice quality seeds.',
    date: DateTime.parse("2020-09-21 20:18:04Z"),
  ),
  TimelineModel(
    id: 't1',
    usercropid: 'uc2',
    title: 'Seeds sowing',
    description: 'I sowed wheat of variety GW-503. It cost me around 40Rs/kg. It was nice quality seeds.',
    date: DateTime.parse("2020-07-21 20:18:04Z"),
  ),
  TimelineModel(
    id: 't2',
    usercropid: 'uc2',
    title: 'Watering',
    description: 'I watred crop after 2 days',
    date: DateTime.parse("2020-07-23 20:18:04Z"),
  ),
  TimelineModel(
    id: 't3',
    usercropid: 'uc2',
    title: 'Fertilizer',
    description: 'Used urea 5kg/1vigha. Cost me 700per/20kg',
    date: DateTime.parse("2020-07-25 20:18:04Z"),
  ),
  TimelineModel(
    id: 't4',
    usercropid: 'uc2',
    title: 'Watering',    
    date: DateTime.parse("2020-07-25 20:18:04Z"),
  ),
];
