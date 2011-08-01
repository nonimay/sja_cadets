Factory.define :cadet do |cadet|
  cadet.firstname     'Fiona'
  cadet.lastname      'McDonald'
  cadet.member_number 1370
  cadet.dob           Date.current - 15.years
  cadet.street        '33 Lunedale Avenue'
  cadet.town          'Sunderland'
  cadet.county        'Tyne and Wear'
  cadet.postcode      'SR68JX'
  cadet.mobile        '07951217515'
  cadet.landline      '01915894545'
  cadet.email         'fiona.mcdonald@northumbria.sja.org.uk'
end
