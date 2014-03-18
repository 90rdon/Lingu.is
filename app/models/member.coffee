attr      = DS.attr
hasMany   = DS.hasMany
belongsTo = DS.belongsTo

member    = DS.Model.extend
  first:      attr()
  last:       attr()
  tagline:    attr()
  bio:        attr()
  image:      attr()
  # images:     hasMany('image', { embedded: true })
  # profiles:   hasMany('profile', { embedded: true })

  fullName: (->
    first   = @get('first') || ''
    last    = @get('last') || ''

    return first + ' ' + last
  ).property('first', 'last')

member.reopenClass
  FIXTURES: [
    {
      "id": 1,
      "images": [ 1 ],
      "first": "Jenny",
      "last": "Wu",
      "tagline": "The best interpreter ever!!",
      "bio": "I am an interpreter with 12 years of experience",
      "profiles": [ 1, 2 ]
    },
    {
      "id": 2,
      "images": [ 2 ],
      "first": "Peter",
      "last": "Li",
      "tagline": "Happy to be your interpreter",
      "bio": "Specialize in business relations in import / export industry",
      "profiles": [ 3 ]
    },
    {
      "id": 3,
      "images": [ 3 ],
      "first": "Grace",
      "last": "Wong",
      "tagline": "Very professional, and trust worthy",
      "bio": "Worked in the fashion industry for over 5 years, can help person interested in factories in China",
      "profiles": [ 4 ]
    },
    {
      "id": 4,
      "images": [ 4 ],
      "first": "Maria",
      "last": "Rosario",
      "tagline": "The best interpreter ever!!",
      "bio": "I am an interpreter with 12 years of experience",
      "profiles": [ 5, 6 ]
    },
    {
      "id": 5,
      "images": [5],
      "first": "Jose",
      "last": "Castro",
      "tagline": "Happy to be your interpreter",
      "bio": "Specialize in business relations in import / export industry",
      "profiles": [ 7 ]
    },
    {
      "id": 6,
      "images": [ 6 ],
      "first": "Miguel",
      "last": "Silva",
      "tagline": "Very professional, and trust worthy",
      "bio": "Worked in the fashion industry for over 5 years, can help person interested in factories in China",
      "profiles": [ 8 ]
    },
    {
      "id": 7,
      "images": [ 7 ],
      "first": "Jose",
      "last": "Pablo",
      "tagline": "Speaks pure Spanish",
      "bio": "Can be a great tour gu_ide with a passion for great food",
      "profiles": [ 9 ]
    },
    {
      "id": 8,
      "images": [ 8 ],
      "first": "Miguel",
      "last": "Perez",
      "tagline": "Easy speaking with a great attitude",
      "bio": "Experience in legal interpretation and medical interpretation",
      "profiles": [ 10 ]
    },
    {
      "id": 9,
      "images": [ 9 ],
      "first": "Alejandra",
      "last": "Abella",
      "tagline": "Fun, Fun, in the Sun",
      "bio": "Knows Ibiza ins_ide and out. I can show you a good time.",
      "profiles": [ 11 ]
    },
    {
      "id": 10,
      "images": [ 10 ],
      "first": "Vlad",
      "last": "Ivanov",
      "tagline": "Over the top support 24/7",
      "bio": "Also fluent in Ukrainian, can direct you to all your needs",
      "profiles": [ 12, 13 ]
    },
    {
      "id": 11,
      "images": [11],
      "first": "Karina",
      "last": "Kuznetsova",
      "tagline": "Your #1 Russian interpreter",
      "bio": "With great knowledge in the finanical industry, I can help you navigate the Russian banking landscape",
      "profiles": [ 14 ]
    },
    {
      "id": 12,
      "images": [12],
      "first": "Anna",
      "last": "Kournikova",
      "tagline": "Nuff Sa_id! Choose wisely",
      "bio": "Years of being a professional tennis player, now I am the best Russain interpreter money can buy. Call me now!",
      "profiles": [ 15 ]
    }
  ]
  
`export default member`