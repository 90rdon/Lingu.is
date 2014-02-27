var path = require('path');
var fs = require('fs');
var fixtureDir = path.resolve(__dirname, '../api-stub', 'data');

module.exports = function(server) {

  // Create an API namespace, so that the root does not 
  // have to be repeated for each end point.
	server.namespace('/api', function() {
		// Return fixture data for '/api/posts/:id'
		server.get('/posts/:id', function(req, res) {
			var post = {
					  "post": {
					    "id": 1,
					    "title": "Rails is omakase",
					    "comments": ["1", "2"],
					    "user" : "dhh"
					  },

					  "comments": [{
					    "id": "1",
					    "body": "Rails is unagi"
					  }, {
					    "id": "2",
					    "body": "Omakase O_o"
					  }]
					};

			res.send(post);
		});

		// /api/members
		// server.get('/members/:id', function(req, res) {
		// 	var member = {
		// 		"members": {
		// 			"id": 8,
		// 	    "images": 'images/profiles/chinese/chinese8.jpg',
		// 	    "title": 'Peter Li',
		// 	    "language": 'chinese'
		// 	   }
		//   };

		// 	res.send(member);
		// });

		server.get('/members', function(req, res) {
	  	var members = JSON.parse(fs.readFileSync(fixtureDir + '/members.json'));

			res.send(members);
		});
	});
};