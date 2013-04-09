<html>
	<head>
		<link href="Resources/style.css" rel="stylesheet" type="text/css"/>
		<meta http-equiv='Content-Type' content='text/html; charset=utf-8'/>
		<script src="Resources/jquery-1.9.1.min.js"></script>
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	</head>
	<div>
	 <form class="user">
			<input type="text" value="Username" onfocus="if (this.value=='Username') this.value='';"/>
		</br>
			<input type="password" value="********" onfocus="if (this.value=='********') this.value='';"/>
		</br>
			<input type="submit" value="Login :)"/>
	</form>
	</div>
		<body>
		<?php 
		session_start();
		$count=1;
		if(isset($_SESSION["count"]))
			$_SESSION["count"]++;
		else
		{
			$_SESSION["count"]=1;
		}
		$count=$_SESSION["count"];
		echo "<h5> You have visited this site </br> " .$count. "times.</h5>";
		?> 
		<div class="wrapper">
			<img src="Resources/kompir.png" class="icon"></img>
			<div class="cutted">
				<header>
					<h1>
						Kompir<span>Traders</span>
					</h1>
				</header>
				<content>
					<aside>
						<div class="buttons">
							<a href="index.php">Home</a>
							<h2>Potatoes by:</h2>
							<a href="potato.html">Variety</a>
							<a href="index.php">Source</a>
							<a href="index.php">Popularity</a>
							<h2>More:</h2>
							<a href="about.html">About</a>
							<a href="index.php">Subscriptions</a>

						</div>
					</aside>
					<div class="main">
						<h2>
							What is <span>Kompir</span>Traders?
						</h2>
							KompirTraders is an online potato trading shop , Designed
							for buyers ranging from big corporations , through small 
							businesses to individual buyers.We offer a wide range of products
							from around the world each with top quality and guaranteed lowest
							prices.
						<h2>
							What do we give that other potato sellers do not? Check for yourself:
						</h2>
						<ul class="checks">
							<li>Low Prices!</li>
							<li>Variety of different products!</li>
							<li>Company Subscriptions!</li>
							<li>Working only with the best sources of potatos!</li>
						</ul>
					</div>
					<div class="add">
					</div>
				</content>
				<footer>
					<span>KompirTraders © All Rights Reserved .</span>
				</footer>
			</div>
		</div>
	</body>
</html>