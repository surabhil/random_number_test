'use strict';

exports.handler = (event, context, callback) => {
	min = event.params.min;
	max = event.params.max;
    getRandomInt(min,max).then(random => {
            const body = {
                "randomnumber": {
                    number: random
                }
            }
            callback(null, {
                statusCode: 200,
                body: JSON.stringify(body)
            })
        })
        .catch(function(error) {
            console.log(error);
        })
};

function getRandomInt(min, max) {
	return new Promise((resolve, reject) => {
    
    if (!min) {
        return res.send({
            "status": "error",
            "message": "missing minimum value"
        });
    } else if (!max) {
        return res.send({
            "status": "error",
            "message": "missing maximum value"
        });
    } else {
        var random = Math.floor(Math.random() * (max - min + 1) + min);
        resolve(random.toString());
    }
});
}
