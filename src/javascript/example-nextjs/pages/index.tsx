import Head from 'next/head'

export default function Home() {
    return (
        <div>
            <Head>
                <title>Home</title>
                <meta name="description" content=""/>
            </Head>

            <main>
                <h1>Home</h1>
                <ul>
                    <li><a href="https://site1.brianhenning.me">Website 1</a></li>
                    <li><a href="https://site2.brianhenning.me">Website 2</a></li>
                    <li><a href="https://site3.brianhenning.me">Website 3</a></li>
                    <li><a href="https://site4.brianhenning.me">Website 4</a></li>
                </ul>
            </main>

        </div>
    )
}
