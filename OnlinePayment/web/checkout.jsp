<%-- 
    Document   : checkout
    Created on : 4 May, 2016, 5:34:36 PM
    Author     : Dell
--%>

<%@page import="java.util.Date"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="pack.DBConnection"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>Smart Shop a Ecommerce Online Shopping Category Flat Bootstrap Responsive Website Template | Check Out :: w3layouts</title>
        <!-- for-mobile-apps -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="keywords" content="Smart Shop Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
              Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
            function hideURLbar(){ window.scrollTo(0,1); } </script>
        <!-- //for-mobile-apps -->
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
        <!-- js -->
        <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
        <!-- //js -->
        <!-- cart -->
        <script src="js/simpleCart.min.js"></script>
        <!-- cart -->
        <!-- for bootstrap working -->
        <script type="text/javascript" src="js/bootstrap-3.1.1.min.js"></script>
        <!-- //for bootstrap working -->
        <link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
        <link href='//fonts.googleapis.com/css?family=Lato:400,100,100italic,300,300italic,400italic,700,900,900italic,700italic' rel='stylesheet' type='text/css'>
        <script src="js/jquery.easing.min.js"></script>
    </head>
    <body>
        <!-- header -->
        <%
            String []args={};

            HttpSession user = request.getSession(true);
            String email = "";
            String total = "0.00";
            String count = "0";

            if (user.getAttribute("email") == null) {
                user.setAttribute("login", "failed");

                response.sendRedirect("index.jsp");
            } else {
                email = user.getAttribute("name").toString();
            }
            if (user.getAttribute("cart") != null) {
                total = user.getAttribute("total").toString();
                count = user.getAttribute("count").toString();
            }
        %>
        <div class="header">
            <div class="container">
                <ul>
                    <li><span class="glyphicon glyphicon-time" aria-hidden="true"></span>Free and Fast Delivery</li>
                    <li><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>Free shipping On all orders</li>
                    <li><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span><a href="mailto:info@example.com">info@example.com</a></li>
                </ul>
            </div>
        </div>
        <!-- //header -->
        <!-- header-bot -->
        <div class="header-bot">
            <div class="container">
                <div class="col-md-3 header-left">
                    <h1><a href="index.jsp"><img src="images/logo3.jpg"></a></h1>
                </div>
                <div class="col-md-6 header-middle">
                    <form>
                        <div class="search">
                            <input type="search" value="Search" onfocus="this.value = '';" onblur="if (this.value == '') {
                                        this.value = 'Search';
                                    }" required="">
                        </div>
                        <div class="section_room">
                            <select id="country" onchange="change_country(this.value)" class="frm-field required">
                                <option value="null">All categories</option>
                                <option value="null">Electronics</option>     
                                <option value="AX">kids Wear</option>
                                <option value="AX">Men's Wear</option>
                                <option value="AX">Women's Wear</option>
                                <option value="AX">Watches</option>
                            </select>
                        </div>
                        <div class="sear-sub">
                            <input type="submit" value=" ">
                        </div>
                        <div class="clearfix"></div>
                    </form>
                </div>
                <div class="col-md-3 header-right footer-bottom">
                    <ul>
                        <li><a href="#" class="use1"><span><%=email%></span></a>

                        </li>
                        <li><a class="fb" href="#"></a></li>
                        <li><a class="twi" href="#"></a></li>
                        <li><a class="insta" href="#"></a></li>
                        <li><a class="you" href="#"></a></li>
                    </ul>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
        <!-- //header-bot -->
        <!-- banner -->
        <div class="ban-top">
            <div class="container">
                <div class="top_nav_left">
                    <nav class="navbar navbar-default">
                        <div class="container-fluid">
                            <!-- Brand and toggle get grouped for better mobile display -->
                            <div class="navbar-header">
                                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                                    <span class="sr-only">Toggle navigation</span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                            </div>
                            <!-- Collect the nav links, forms, and other content for toggling -->
                            <div class="collapse navbar-collapse menu--shylock" id="bs-example-navbar-collapse-1">
                                <ul class="nav navbar-nav menu__list">
                                    <li class="active menu__item menu__item--current"><a class="menu__link" href="index.jsp">Home <span class="sr-only">(current)</span></a></li>
                                    <li class="dropdown menu__item">
                                        <a href="#" class="dropdown-toggle menu__link" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">men's wear <span class="caret"></span></a>
                                        <ul class="dropdown-menu multi-column columns-3">
                                            <div class="row">
                                                <div class="col-sm-6 multi-gd-img1 multi-gd-text ">
                                                    <a href="mens.jsp"><img src="images/woo1.jpg" alt=" "/></a>
                                                </div>
                                                <div class="col-sm-3 multi-gd-img">
                                                    <ul class="multi-column-dropdown">
                                                        <li><a href="mens.jsp?clothing">Clothing</a></li>
                                                        <li><a href="mens.jsp?wallets">Wallets</a></li>
                                                        <li><a href="mens.jsp?footwear">Footwear</a></li>
                                                        <li><a href="mens.jsp?watches">Watches</a></li>
                                                        <li><a href="mens.jsp?bags">Bags</a></li>
                                                        <li><a href="mens.jsp?sunglasses">Sunglasses</a></li>
                                                        <li><a href="mens.jsp?caps">Caps & Hats</a></li>
                                                    </ul>
                                                </div>

                                            </div>
                                        </ul>
                                    </li>
                                    <li class="dropdown menu__item">
                                        <a href="#" class="dropdown-toggle menu__link" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">women's wear <span class="caret"></span></a>
                                        <ul class="dropdown-menu multi-column columns-3">
                                            <div class="row">
                                                <div class="col-sm-6 multi-gd-img1 multi-gd-text ">
                                                    <a href="womens.jsp"><img src="images/woo.jpg" alt=" "/></a>
                                                </div>
                                                <div class="col-sm-3 multi-gd-img">
                                                    <ul class="multi-column-dropdown">
                                                        <li><a href="womens.jsp?clothing">Clothing</a></li>
                                                        <li><a href="womens.jsp?wallets">Wallets</a></li>
                                                        <li><a href="womens.jsp?footwear">Footwear</a></li>
                                                        <li><a href="womens.jsp?watches">Watches</a></li>
                                                        <li><a href="womens.jsp?bags">Bags</a></li>
                                                        <li><a href="womens.jsp?jewellery">Jewellery</a></li>
                                                        <li><a href="womens.jsp?caps">Caps & Hats</a></li>
                                                    </ul>
                                                </div>

                                                <div class="clearfix"></div>
                                            </div>
                                        </ul>
                                    </li>
                                    <li class="dropdown menu__item">
                                        <a href="#" class="dropdown-toggle menu__link" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Electronics<span class="caret"></span></a>
                                        <ul class="dropdown-menu multi-column columns-3">
                                            <div class="row">
                                                <div class="col-sm-6 multi-gd-img1 multi-gd-text ">
                                                    <a href="electronics.jsp"><img src="images/woo2.jpg" alt=" "/></a>
                                                </div>
                                                <div class="col-sm-3 multi-gd-img">
                                                    <ul class="multi-column-dropdown">
                                                        <li><a href="electronics.jsp?mobiles">Mobiles</a></li>
                                                        <li><a href="electronics.jsp?tablets">Tablets</a></li>
                                                        <li><a href="electronics.jsp?computers">Computers</a></li>
                                                        <li><a href="electronics.jsp?large">Large Applications</a></li>
                                                        <li><a href="electronics.jsp?tv">Televisions</a></li>
                                                        <li><a href="electronics.jsp?cameras">Cameras</a></li>
                                                        <li><a href="electronics.jsp?kitchen">Kitchen Appliances</a></li>
                                                    </ul>
                                                </div>

                                                <div class="clearfix"></div>
                                            </div>
                                        </ul>
                                    </li>
                                    <li class=" menu__item"><a class="menu__link" href="orderstatus.jsp">order Status</a></li>
                                    <li class=" menu__item"><a class="menu__link" href="logout.jsp">log out</a></li> </ul>
                            </div>
                        </div>
                    </nav>	
                </div>
                <div class="top_nav_right">
                    <div class="cart box_1">
                        <a href="checkout.jsp">
                            <h3> <div class="total">
                                    <i class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></i>
                                    <span>$<%=total%></span> (<span><%=count%></span> items)</div>

                            </h3>
                        </a>
                        <p><a href="javascript:;" class="simpleCart_empty">Empty Cart</a></p>

                    </div>	
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
        <!-- //banner-top -->
        <!-- banner -->
        <div class="page-head">
            <div class="container">
                <h3>Check Out</h3>
            </div>
        </div>
        <!-- //banner -->
        <!-- check out -->
        <div class="checkout">
            <div class="container">
                <h3>My Shopping Bag</h3>
                <div class="table-responsive checkout-right animated wow slideInUp" data-wow-delay=".5s" style="height: 300px">
                    <table class="timetable_sub" style="overflow: scroll">
                        <thead>
                            <tr>
                                <th>Remove</th>
                                <th>Product</th>
                                <th>Quantity</th>
                                <th>Product Name</th>
                                <th>Price</th>
                            </tr>
                        </thead>
                        <%

                            ArrayList cart = null;
                            ArrayList bag = new ArrayList();
                            DBConnection db = new DBConnection();
                            if (user.getAttribute("cart") == null) {
                        %>
                        <tr>
                            <td>There is no item in your cart</td>
                        </tr>
                        <%                                    } else {
                                cart = (ArrayList) user.getAttribute("cart");
                            }
                            int cnt = 0;
                            Random rnd = new Random();
                            int orderid = rnd.nextInt(9999) + 1111;
                            Date d = new Date();
                            if (cart != null) {
                                for (int i = 0; i < cart.size(); i++) {
                                    String id = cart.get(i).toString();
                                    Statement st = db.st;
                                    ResultSet rs = st.executeQuery("select * from items where id='" + id + "'");
                                    if (rs.next()) {
                                        String image = rs.getString("path");
                                        String price = rs.getString("dprice");
                                        String name = rs.getString("name");
                                        bag.add(name + "," + price);
                                        user.setAttribute("price", price);
                                        cnt = 1;
                                        int cnt1 = cnt++;
                                        user.setAttribute("cnt1", cnt1);
                                        user.setAttribute("orderid", orderid);
                                        user.setAttribute("d1", d);
                                        user.setAttribute("id", id);

                        %>
                        <tr class="rem1">
                            <td class="invert-closeb">
                                <div class="rem">
                                    <a href="removefromcart.jsp?<%=id%>" class="close1"> </a>
                                </div>

                            </td>
                            <td class="invert-image" style="width:30%;"><a href="#"><img src="images/<%=image%>" alt=" " class="img-responsive" /></a></td>
                            <td class="invert"> <%=cnt%></td>
                            <td class="invert"><%=name%></td>
                            <td class="invert">$<%=price%></td>
                        </tr>   
                        <%   }
                                }
                            }
                        %>




                    </table>
                </div>

                <div class="checkout-left">	

                    <div class="checkout-right-basket animated wow slideInRight" data-wow-delay=".5s">
                        <a href="mens.jsp"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>Back To Shopping</a>
                        <a href="carddetails.jsp"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>Checkout</a>
                    </div>
                    <div class="checkout-left-basket animated wow slideInLeft" data-wow-delay=".5s" style="width: 350px">
                        <h4>Shopping basket</h4>
                        <ul>
                            <%  try {
                                    double total1 = 0;
                                    for (int i = 0; i < bag.size(); i++) {
                                        String str[] = bag.get(i).toString().split(",");
                                        total1 = total1 + Double.parseDouble(str[1]);
                                        user.setAttribute("total1", total1);
                            %>
                            <li><%=str[0]%> <i>-</i> <span>$<%=str[1]%></span></li>

                            <%
                                }%>
                            <li>Total <i>-</i> <span>$<%=total1%></span></li>
                                <%} catch (Exception e) {
                                        e.printStackTrace();
                                    }%>
                        </ul>
                    </div>
                    <div class="clearfix"> </div>
                </div>
            </div>
        </div>	
        <!-- //check out -->
        <!-- //product-nav -->
        <div class="coupons">
            <div class="container">
                <div class="coupons-grids text-center">
                    <div class="col-md-3 coupons-gd">
                        <h3>Buy your product in a simple way</h3>
                    </div>
                    <div class="col-md-3 coupons-gd">
                        <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                        <h4>LOGIN TO YOUR ACCOUNT</h4>
                        <p>Neque porro quisquam est, qui dolorem ipsum quia dolor
                            sit amet, consectetur.</p>
                    </div>
                    <div class="col-md-3 coupons-gd">
                        <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
                        <h4>SELECT YOUR ITEM</h4>
                        <p>Neque porro quisquam est, qui dolorem ipsum quia dolor
                            sit amet, consectetur.</p>
                    </div>
                    <div class="col-md-3 coupons-gd">
                        <span class="glyphicon glyphicon-credit-card" aria-hidden="true"></span>
                        <h4>MAKE PAYMENT</h4>
                        <p>Neque porro quisquam est, qui dolorem ipsum quia dolor
                            sit amet, consectetur.</p>
                    </div>
                    <div class="clearfix"> </div>
                </div>
            </div>
        </div>
        <!-- footer -->
        <div class="footer">
            <div class="container">
                <div class="col-md-3 footer-left">
                    <h2><a href="index.jsp"><img src="images/logo3.jpg" alt=" " /></a></h2>
                    <p>Neque porro quisquam est, qui dolorem ipsum quia dolor
                        sit amet, consectetur, adipisci velit, sed quia non 
                        numquam eius modi tempora incidunt ut labore 
                        et dolore magnam aliquam quaerat voluptatem.</p>
                </div>
                <div class="col-md-9 footer-right">
                    <div class="col-sm-6 newsleft">
                        <h3>SIGN UP FOR NEWSLETTER !</h3>
                    </div>
                    <div class="col-sm-6 newsright">
                        <form>
                            <input type="text" value="Email" onfocus="this.value = '';" onblur="if (this.value == '') {
                                        this.value = 'Email';
                                    }" required="">
                            <input type="submit" value="Submit">
                        </form>
                    </div>
                    <div class="clearfix"></div>
                    <div class="sign-grds">
                        <div class="col-md-4 sign-gd">
                            <h4>Information</h4>
                            <ul>
                                <li><a href="index.jsp">Home</a></li>
                                <li><a href="mens.jsp">Men's Wear</a></li>
                                <li><a href="womens.jsp">Women's Wear</a></li>
                                <li><a href="electronics.jsp">Electronics</a></li>
                                <li><a href="contact.jsp">Contact</a></li>
                            </ul>
                        </div>

                        <div class="col-md-4 sign-gd-two">
                            <h4>Store Information</h4>
                            <ul>
                                <li><i class="glyphicon glyphicon-map-marker" aria-hidden="true"></i>Address : 1234k Avenue, 4th block, <span>Newyork City.</span></li>
                                <li><i class="glyphicon glyphicon-envelope" aria-hidden="true"></i>Email : <a href="mailto:info@example.com">info@example.com</a></li>
                                <li><i class="glyphicon glyphicon-earphone" aria-hidden="true"></i>Phone : +1234 567 567</li>
                            </ul>
                        </div>
                        <div class="col-md-4 sign-gd flickr-post">
                            <h4>Flickr Posts</h4>
                            <ul>
                                <li><a href="single.jsp"><img src="images/b15.jpg" alt=" " class="img-responsive" /></a></li>
                                <li><a href="single.jsp"><img src="images/b16.jpg" alt=" " class="img-responsive" /></a></li>
                                <li><a href="single.jsp"><img src="images/b17.jpg" alt=" " class="img-responsive" /></a></li>
                                <li><a href="single.jsp"><img src="images/b18.jpg" alt=" " class="img-responsive" /></a></li>
                                <li><a href="single.jsp"><img src="images/b15.jpg" alt=" " class="img-responsive" /></a></li>
                                <li><a href="single.jsp"><img src="images/b16.jpg" alt=" " class="img-responsive" /></a></li>
                                <li><a href="single.jsp"><img src="images/b17.jpg" alt=" " class="img-responsive" /></a></li>
                                <li><a href="single.jsp"><img src="images/b18.jpg" alt=" " class="img-responsive" /></a></li>
                                <li><a href="single.jsp"><img src="images/b15.jpg" alt=" " class="img-responsive" /></a></li>
                            </ul>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="clearfix"></div>
                <p class="copy-right">&copy 2016 Smart Shop. All rights reserved | Design by <a href="http://w3layouts.com/">W3layouts</a></p>
            </div>
        </div>
        <!-- //footer -->
        <!-- login -->

        <!-- //login -->
    </body>
</html>

