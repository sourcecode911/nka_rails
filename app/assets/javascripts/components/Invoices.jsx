class Invoices extends React.Component {
    constructor(props) {
        super();
        console.log(props);
        this.state = {
            items: props.items
        }
    }

    renderHeader() {
        return (
            <tr>
                <th>#</th>
                <th>Jahr</th>
            </tr>
        )
    }

    renderItems() {
        return this.state.items.map((item) => {
            return (
                <tr key={item.id}>
                    <td>{item.id}</td>
                    <td>{item.year}</td>
                </tr>
            )
        });
    }

    render() {
        return (
            <Datatable renderHeader={() => (this.renderHeader())}>
                {this.renderItems()}
            </Datatable>
        );
    }
}
