#encoding: utf-8

Course.delete_all

Course.create!([{ name: '语文'}, {name: '数学'}, {name: '英语'}, {name: '物理'}, {name: '化学'}, {name: '历史'}, {name: '生物'}, {name: '地理'}, {name: '思想政治'}])

Grade.delete_all

Grade.create!([{ name: '必修1'}, { name: '必修2'}, { name: '必修3'}, { name: '必修4'}, { name: '必修5'}])

Place.delete_all

Place.create!([{ name: '人教版'}, { name: '北师大版'}, { name: '苏教版'}, { name: '沪教版'}])
