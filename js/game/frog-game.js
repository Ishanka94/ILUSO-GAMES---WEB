var game = new Phaser.Game(3000, 600, Phaser.AUTO, 'mygame', { preload: preload, create: create, update: update });

            function preload() {

                game.load.image('sky', 'images/assets/sky.jpg');
                game.load.image('ground', 'images/assets/platform.png');
                game.load.image('star', 'images/assets/star.png');
                game.load.image('frog', 'images/assets/frog4.png');
                game.load.spritesheet('dude', 'images/assets/dude.png', 32, 48);

                game.load.audio('sound1', 'audio/frog-sound2.mp3');

            }

            var player;
            var platforms;
            var cursors;
            var frogs;

            var stars;
            var score = 0;
            var scoreText;
            var final;

            var sound1;

            function create() {

                //  We're going to be using physics, so enable the Arcade Physics system
                game.physics.startSystem(Phaser.Physics.ARCADE);

                //  A simple background for our game
                var mySky = game.add.sprite(0, 0, 'sky');
                mySky.scale.setTo(3, 2);
                //  The platforms group contains the ground and the 2 ledges we can jump on
                platforms = game.add.group();

                //  We will enable physics for any object that is created in this group
                platforms.enableBody = true;

                // Here we create the ground.
                var ground = platforms.create(0, game.world.height - 64, 'ground');

                //  Scale it to fit the width of the game (the original sprite is 400x32 in size)
                ground.scale.setTo(4, 2);

                //  This stops it from falling away when you jump on it
                ground.body.immovable = true;

                //  Now let's create two ledges
                var ledge = platforms.create(400, 400, 'ground');
                ledge.body.immovable = true;

                ledge = platforms.create(-150, 250, 'ground');
                ledge.body.immovable = true;

                // The player and its settings
                player = game.add.sprite(32, game.world.height - 150, 'dude');

                //  We need to enable physics on the player
                game.physics.arcade.enable(player);

                //  Player physics properties. Give the little guy a slight bounce.
                player.body.bounce.y = 0.2;
                player.body.gravity.y = 300;
                player.body.collideWorldBounds = true;

                //  Our two animations, walking left and right.
                player.animations.add('left', [0, 1, 2, 3], 10, true);
                player.animations.add('right', [5, 6, 7, 8], 10, true);

                //  Finally some stars to collect
                stars = game.add.group();

                //  We will enable physics for any star that is created in this group
                stars.enableBody = true;

                //  Here we'll create 12 of them evenly spaced apart
                for (var i = 0; i < 12; i++)
                {
                    //  Create a star inside of the 'stars' group
                    var star = stars.create(i * 70, 0, 'star');

                    //  Let gravity do its thing
                    star.body.gravity.y = 300;

                    //  This just gives each star a slightly random bounce value
                    star.body.bounce.y = 0.7 + Math.random() * 0.2;
                }

                frogs = game.add.group();
                frogs.enableBody = true;
                for(var j = 1; j < 8; j++)
                {
                    var frog = frogs.create(j*152, 0, 'frog');
                    frog.body.gravity.y = 180;
                    frog.body.bounce.y = 0.7 + Math.random() * 0.2;
                }




                sound1 = game.add.audio('sound1');
                //sound1.play();



                //  The score
                scoreText = game.add.text(16, 16, 'score: 0', { fontSize: '32px', fill: '#000' });
                final = game.add.text(450, 250, '', { fontSize: '32px', fill: '#000' });

                //  Our controls.
                cursors = game.input.keyboard.createCursorKeys();
                
            }

            function update() {

                if(!sound1.isPlaying){
                    sound1.play();
                }

                //  Collide the player and the stars with the platforms
                game.physics.arcade.collide(player, platforms);
                game.physics.arcade.collide(stars, platforms);
                game.physics.arcade.collide(frogs, platforms);

                //  Checks to see if the player overlaps with any of the stars, if he does call the collectStar function
                game.physics.arcade.overlap(player, stars, collectStar, null, this);
                game.physics.arcade.overlap(player, frogs, gameOver, null, this);

                //  Reset the players velocity (movement)
                player.body.velocity.x = 0;

                if (cursors.left.isDown)
                {
                    //  Move to the left
                    player.body.velocity.x = -150;

                    player.animations.play('left');
                }
                else if (cursors.right.isDown)
                {
                    //  Move to the right
                    player.body.velocity.x = 150;

                    player.animations.play('right');
                }
                else
                {
                    //  Stand still
                    player.animations.stop();

                    player.frame = 4;
                }
                
                //  Allow the player to jump if they are touching the ground.
                if (cursors.up.isDown && player.body.touching.down)
                {
                    player.body.velocity.y = -350;
                }

            }

            function collectStar (player, star) {
                
                // Removes the star from the screen
                star.kill();

                //  Add and update the score
                score += 10;
                scoreText.text = 'Score: ' + score;
                if(score == 120){
                    final.text = 'You Win!!';
                }

            }

            function gameOver(player, frog){
                player.kill();
                final.text = 'Game Over!';
                game.physics.arcade.collide(player);
            }