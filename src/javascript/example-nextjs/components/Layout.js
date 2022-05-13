
export default function Layout({children}) {
    return (
      <header>
      <nav className="navbar navbar-expand-lg navbar-light primary-color">
     <div className="collapse navbar-collapse" id="navbarNav">
      <ul className="navbar-nav">
      <li className="nav-item active">
        <a className="nav-link" href="/">Home</a>
      </li>
      <li className="nav-item">
        <a className="nav-link" href="/nhl">NHL</a>
      </li>
      <li className="nav-item">
        <a className="nav-link" href="/mlb">MLB</a>
      </li>
      <li className="nav-item">
          <a className="nav-link" href="/nfl">NFL</a>
      </li>
      <li className="nav-item">
          <a className="nav-link" href="/howto">Howto</a>
      </li>
      <li className="nav-item">
        <a className="nav-link" href="/temperature">Temperature</a>
      </li>
    </ul>
  </div>
</nav>
        {children}
      </header>
    )
    }
