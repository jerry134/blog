#encoding: utf-8

Course.delete_all

Course.create!([{ name: '语文'}, {name: '数学'}, {name: '英语'}, {name: '物理'}, {name: '化学'}, {name: '历史'}, {name: '生物'}, {name: '地理'}, {name: '思想政治'}])
