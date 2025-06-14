<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Random travel quotes
    String[] quotes = {
        "\"The journey of a thousand miles begins with a single step.\" ? Lao Tzu",
        "\"Life is short and the world is wide.\" ? Simon Raven",
        "\"Travel makes one modest. You see what a tiny place you occupy in the world.\" ? Gustave Flaubert",
        "\"Wherever you go, go with all your heart.\" ? Confucius",
        "\"Adventure is worthwhile.\" ? Aesop"
    };
    int randomIndex = (int) (Math.random() * quotes.length);
    String quoteToShow = quotes[randomIndex];
%>

<jsp:include page="includes/header.jsp"/>

<div class="welcome-box shadow-sm p-4 mb-4 rounded">
    <h2 class="mb-3">Welcome, <%= user.getFullName() %>!</h2>
    <p class="status mb-1">RAIL SERVICE STATUS: <strong class="text-success">NORMAL</strong></p>
    <span class="role badge bg-secondary">Role: <%= user.getRole() %></span>
</div>

<div class="row g-4 mb-4">

    <!-- Book Ticket -->
    <div class="col-md-3">
        <div class="card h-100 shadow-sm">
            <div class="card-body text-center">
                <h5 class="card-title">Book Ticket</h5>
                <p>Reserve your next journey in just a few clicks.</p>
                <a href="book_ticket.jsp" class="btn btn-primary w-100 mt-3">Book Now</a>
            </div>
        </div>
    </div>

    <!-- View Schedule -->
    <div class="col-md-3">
        <div class="card h-100 shadow-sm">
            <div class="card-body text-center">
                <h5 class="card-title">View Schedule</h5>
                <p>Check train departure and arrival times easily.</p>
                <a href="schedule.jsp" class="btn btn-primary w-100 mt-3">View</a>
            </div>
        </div>
    </div>

    <!-- Promotions -->
    <div class="col-md-3">
        <div class="card h-100 shadow-sm">
            <div class="card-body text-center">
                <h5 class="card-title">Promotions</h5>
                <p>Discover new discounts and special offers.</p>
                <a href="promotion.jsp" class="btn btn-primary w-100 mt-3">Explore</a>
            </div>
        </div>
    </div>

    <!-- Contact Support -->
    <div class="col-md-3">
        <div class="card h-100 shadow-sm">
            <div class="card-body text-center">
                <h5 class="card-title">Contact Support</h5>
                <p>Need help? Contact our customer care anytime.</p>
                <a href="contact.jsp" class="btn btn-primary w-100 mt-3">Support</a>
            </div>
        </div>
    </div>
</div>

<!-- NEW ROW: My Bookings -->
<div class="row g-4 mb-4">
    <div class="col-md-3">
        <div class="card h-100 shadow-sm bg-light">
            <div class="card-body text-center">
                <h5 class="card-title">My Bookings</h5>
                <p>View all your past and current ticket bookings.</p>
                <a href="my_bookings.jsp" class="btn btn-outline-primary w-100 mt-3">View Bookings</a>
            </div>
        </div>
    </div>

    <!-- Optional Empty Placeholder -->
    <div class="col-md-9 d-none d-md-block">
        <div class="card h-100 border-0"></div>
    </div>
</div>

<!-- ? Replaced: Quote of the Day -->
<div class="alert alert-info text-center p-5 rounded shadow-sm">
    <h4><%= quoteToShow %></h4>
</div>
<br>
<jsp:include page="includes/footer.jsp"/>
