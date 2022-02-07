import Link from 'next/link'
// export default function Cars() {
//   return <h1>This is the cars list</h1>

// }

export default function Cars() {
  return (
    <div>
        <h1>
          Cars list
        </h1>

        <ul>
          <li>
            <Link href="/cars/tesla"><a>Tesla</a></Link>
          </li>
          <li>
            <Link href="/cars/ford"><a>Ford</a></Link>
          </li>
        </ul>
    </div>
  )
  }
