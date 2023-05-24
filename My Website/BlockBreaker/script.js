//set up canvas
const canvas = document.querySelector('canvas');
const ctx = canvas.getContext('2d');

const width = canvas.width = 900;
const height = canvas.height = 900;

//global vars
const PADDLEWIDTH = 150;
const PADDLEHEIGHT = height - 35;
const BALLSIZE = 10;
const BRICKW = 75;
const BRICKH = 20;
const BRICKCOL = 10;
const BRICKROW = 5;
const BRICKPAD = 5;
const BRICKOFFTOP = 30;
const BRICKOFFLEFT = (width/2) - (BRICKCOL*(BRICKW+BRICKPAD))/2;
var paddleX = 0;
const gameOver = document.querySelector('#gameOver');

function getMousePos(canvas, evt) {
  var rect = canvas.getBoundingClientRect();
  return {
    x: evt.clientX - rect.left,
    y: evt.clientY - rect.top
  };
}

//position and speed of shapes
class Shape {
  constructor(x, y, velX, velY) {
    this.x = x;
    this.y = y;
    this.velX = velX;
    this.velY = velY;
  }}


//create Backdrop
class Backdrop extends Shape {
  constructor(x, y) {
    super(x, y, 0, 0);
  }

  draw() {
    ctx.beginPath();
    ctx.fillStyle = 'rgba(0, 0, 0, 0.25)';
    ctx.fillRect(this.x, this.y, width, height);
  }
}

//create paddle
class Paddle extends Shape {
  constructor(x, y) {
    super(x, y, 0, 0);

    //follow mouse movements
    window.addEventListener('mousemove', e => {
      var pos = getMousePos(canvas, e)
      if (pos.x < width - PADDLEWIDTH/2 && pos.x > PADDLEWIDTH/2) {
        this.x = pos.x - PADDLEWIDTH/2;
      }
    });
  }

  draw() {
    ctx.beginPath();
    ctx.fillStyle = 'gray';
    ctx.fillRect(this.x, this.y, PADDLEWIDTH, 10);
  }
}

//create Ball
class Ball extends Shape {
  constructor(x, y) {
    super(x, y, -10, -11);
  }

  draw() {
    ctx.beginPath();
    ctx.fillStyle = 'red';
    ctx.arc(this.x, this.y, BALLSIZE, 0, 2 * Math.PI);
    ctx.fill();
  }

  move() {
    if (this.x - BALLSIZE <= 0) {
      this.velX = -this.velX;
    }
    if (this.x + BALLSIZE >= width) {
      this.velX = -this.velX;
    }
    if (this.y - BALLSIZE <= 0) {
      this.velY = -this.velY;
    }
    if (this.y + BALLSIZE >= height) {
      if (this.x > paddle.x && this.x < paddle.x + PADDLEWIDTH && this.y > paddle.y && this.y < paddle.y + PADDLEHEIGHT){
        this.velY = -this.velY;
      } else {
          gameOver.className = "active";
          this.velX = 0;
          this.velY = 0;
      }
    }
    this.x += this.velX;
    this.y += this.velY;
  }
  
  collisionDetect(){
    for (const brick of bricks){
      if (brick.exists){
        if (this.x > brick.x && this.x < brick.x+BRICKW && this.y > brick.y && this.y < brick.y+BRICKH){
          this.velY = -this.velY;
          brick.exists = false;
        }
      }
    }
  }
  
}

//create brick
class Brick extends Shape{
  constructor(x, y, exists = true){
    super(x, y, 0, 0);
    this.exists = exists;
  }
  
  draw() {
    ctx.beginPath();
    ctx.fillStyle = 'blue';
    ctx.fillRect(this.x, this.y, BRICKW, BRICKH);
  }
}

//create objects
const back = new Backdrop(0, 0);
const paddle = new Paddle(width / 2 - PADDLEWIDTH / 2, PADDLEHEIGHT);
const ball = new Ball(width / 2, height - 45);
var bricks = []
for (c=0; c < BRICKCOL; c++){
    for (r=0; r < BRICKROW; r++){
      var brickX = (c*(BRICKW+BRICKPAD))+BRICKOFFLEFT;
      var brickY = (r*(BRICKH+BRICKPAD))+BRICKOFFTOP;
      const brick =  new Brick(brickX, brickY);
      bricks.push(brick);
      }
  }

function loop() {
  back.draw();
  for (brick of bricks){
    if (brick.exists){  
      brick.draw();
    }
  }
  paddle.draw();
  ball.draw();
  ball.move();
  ball.collisionDetect();
  requestAnimationFrame(loop);
}

//button control to call loop function and clear div
const btn = document.querySelector("button");
const activeDiv = document.querySelector(".active");

btn.addEventListener("click", () => {
  activeDiv.className = "inactive";
  loop();
});

//refresh page
const gameOverBtn = document.querySelector('#gameOverBtn');
gameOverBtn.addEventListener("click", () => {
  window.location.reload();
});