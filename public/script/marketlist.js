function redirect(id) {
    window.location.replace(`https://onetrip.now.sh/storepage.ejs?storeid=${id}`);
}

let search = document.getElementById('inputBox');

document.querySelector('form.pure-form').addEventListener('submit', function(e) {
    e.preventDefault();
    // console.log(search.value);

    if (search.value == "One Trip") {
        document.getElementById("easteregg").style.visibility = 'visible';

        let SCREEN_WIDTH = window.innerWidth
        let SCREEN_HEIGHT = window.innerHeight
        let mousePos = {
                x: 400,
                y: 300
            },

            // create canvas
            canvas = document.createElement('canvas'),
            context = canvas.getContext('2d'),
            particles = [],
            rockets = [],
            MAX_PARTICLES = 400,
            colorCode = 0;

        // init
        $(document).ready(function() {
            document.body.appendChild(canvas);
            canvas.style.cssText = "position: absolute; top: 0px; left: 0px; z-dindex: 1; ";

            canvas.width = SCREEN_WIDTH;
            canvas.height = SCREEN_HEIGHT;
            setInterval(launch, 200);
            setInterval(loop, 1000 / 50);
        });

        // update mouse position
        $(document).mousemove(function(e) {
            e.preventDefault();
            mousePos = {
                x: e.clientX,
                y: e.clientY
            };
        });

        // launch a lot rockets 
        $(document).mousedown(function(e) {
            for (let i = 0; i < 5; i++) {
                launchFrom(Math.random() * SCREEN_WIDTH * 2 / 3 + SCREEN_WIDTH / 6);
            }
        });

        function launch() {
            launchFrom(Math.random() * SCREEN_WIDTH);
            // launchFrom(mousePos.x); 마우스 x 좌표에서 따라가고 싶을때
        }

        function launchFrom(x) {
            if (rockets.length < 30) {
                let rocket = new Rocket(x);
                rocket.explosionColor = Math.floor(Math.random() * 360 / 10) * 10;
                rocket.vel.y = Math.random() * -3 - 4;
                rocket.vel.x = Math.random() * 6 - 3;
                rocket.size = 13;
                rocket.shrink = 0.999;
                rocket.gravity = 0.01; // 1 = explode at the bottom
                rockets.push(rocket);
            }
        }

        function loop() {
            // update screen size
            if (SCREEN_WIDTH != window.innerWidth) {
                canvas.width = SCREEN_WIDTH = window.innerWidth;
            }
            if (SCREEN_HEIGHT != window.innerHeight) {
                canvas.height = SCREEN_HEIGHT = window.innerHeight;
            }

            // clear canvas
            context.fillStyle = "rgba(0, 0, 0, 0.05)";
            context.fillRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

            let existingRockets = [];

            for (let i = 0; i < rockets.length; i++) {
                // update and render
                rockets[i].update();
                rockets[i].render(context);

                // calculate distance with Pythagoras
                let distance = Math.sqrt(Math.pow(mousePos.x - rockets[i].pos.x, 2) + Math.pow(mousePos.y - rockets[i].pos.y, 2));

                // random chance of 1% if rockets is above the middle
                let randomChance = rockets[i].pos.y < (SCREEN_HEIGHT * 3 / 4) ? (Math.random() * 100 <= 1) : false;


                /* Explosion rules
                    - 80% of screen
                    - going down
                    - close to the mouse
                    - 1% chance of random explosion
                */

                if (rockets[i].pos.y < SCREEN_HEIGHT / 5 || rockets[i].vel.y >= 0 || distance < 65 || randomChance) {
                    rockets[i].explode();
                } else {
                    existingRockets.push(rockets[i]);
                }
            }

            rockets = existingRockets;

            let existingParticles = [];

            for (let i = 0; i < particles.length; i++) {
                particles[i].update();

                // render and save particles that can be rendered
                if (particles[i].exists()) {
                    particles[i].render(context);
                    existingParticles.push(particles[i]);
                }
            }

            // update array with existing particles - old particles should be garbage collected
            particles = existingParticles;

            while (particles.length > MAX_PARTICLES) {
                particles.shift();
            }
        }

        function Particle(pos) {
            this.pos = {
                x: pos ? pos.x : 0,
                y: pos ? pos.y : 0
            };
            this.vel = {
                x: 0,
                y: 0
            };
            this.shrink = .97;
            this.size = 2;

            this.resistance = 1;
            this.gravity = 0;

            this.flick = false;

            this.alpha = 1;
            this.fade = 0;
            this.color = 0;
        }

        Particle.prototype.update = function() {
            // apply resistance
            this.vel.x *= this.resistance;
            this.vel.y *= this.resistance;

            // gravity down
            this.vel.y += this.gravity;

            // update position based on speed
            this.pos.x += this.vel.x;
            this.pos.y += this.vel.y;

            // shrink
            this.size *= this.shrink;

            // fade out
            this.alpha -= this.fade;
        };

        Particle.prototype.render = function(c) {
            if (!this.exists()) {
                return;
            }

            c.save();

            c.globalCompositeOperation = 'lighter';

            let x = this.pos.x
            let y = this.pos.y
            let r = this.size / 2;

            let gradient = c.createRadialGradient(x, y, 0.1, x, y, r);
            gradient.addColorStop(0.1, "rgba(255,255,255," + this.alpha + ")");
            gradient.addColorStop(0.8, "hsla(" + this.color + ", 100%, 50%, " + this.alpha + ")");
            gradient.addColorStop(1, "hsla(" + this.color + ", 100%, 50%, 0.1)");

            c.fillStyle = gradient;

            c.beginPath();
            c.arc(this.pos.x, this.pos.y, this.flick ? Math.random() * this.size : this.size, 0, Math.PI * 2, true);
            c.closePath();
            c.fill();

            c.restore();
        };

        Particle.prototype.exists = function() {
            return this.alpha >= 0.1 && this.size >= 1;
        };

        function Rocket(x) {
            Particle.apply(this, [{
                x: x,
                y: SCREEN_HEIGHT
            }]);

            this.explosionColor = 0;
        }

        Rocket.prototype = new Particle();
        Rocket.prototype.constructor = Rocket;

        Rocket.prototype.explode = function() {
            let count = Math.random() * 10 + 80;

            for (let i = 0; i < count; i++) {
                let particle = new Particle(this.pos);
                let angle = Math.random() * Math.PI * 2;

                // emulate 3D effect by using cosine and put more particles in the middle
                let speed = Math.cos(Math.random() * Math.PI / 2) * 20;

                particle.vel.x = Math.cos(angle) * speed;
                particle.vel.y = Math.sin(angle) * speed;

                particle.size = 10;

                particle.gravity = 0.2;
                particle.resistance = 0.92;
                particle.shrink = Math.random() * 0.05 + 0.93;

                particle.flick = true;
                particle.color = this.explosionColor;

                particles.push(particle);
            }
        };

        Rocket.prototype.render = function(c) {
            if (!this.exists()) {
                return;
            }

            c.save();

            c.globalCompositeOperation = 'lighter';

            let x = this.pos.x
            let y = this.pos.y
            let r = this.size / 2;

            let gradient = c.createRadialGradient(x, y, 0.1, x, y, r);
            gradient.addColorStop(0.1, "rgba(255, 255, 255 ," + this.alpha + ")");
            gradient.addColorStop(1, "rgba(0, 0, 0, " + this.alpha + ")");

            c.fillStyle = gradient;

            c.beginPath();
            c.arc(this.pos.x, this.pos.y, this.flick ? Math.random() * this.size / 2 + this.size / 2 : this.size, 0, Math.PI * 2, true);
            c.closePath();
            c.fill();

            c.restore();
        };
    }
    setTimeout(function() {
        document.getElementById('easteregg').style.display = 'none';
        location.reload()
    }, 7000);

})