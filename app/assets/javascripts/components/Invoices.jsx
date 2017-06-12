class Invoices extends React.Component {
    constructor(props) {
        super();
        this.url = props.url;
        this.state = {
            items: props.items,
            invoice_id: props.invoice_id
        }
    }

    renderHeader() {
        return (
            <tr>
                <th>#</th>
                <th>Jahr</th>
                <th />
            </tr>
        )
    }

    selectInvoice(item) {
        httpPut('/users/' + this.props.user_id, {user: {current_invoice_id: item.id}}, (resp) => {
            this.setState({invoice_id: resp.current_invoice_id})
        });
    }

    renderItems() {
        return this.state.items.map((item) => {
            return (
                <tr key={item.id} className={item.id === this.state.invoice_id ? 'active' : ''}>
                    <td>{item.id}</td>
                    <td>{item.year}</td>
                    <td className="link" onClick={() => {this.selectInvoice(item)}}>Selektieren</td>
                    <td><a href={`${this.url}/${item.id}/finalize`}>Abrechnen</a></td>
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

Invoices.propTypes = {
    user_id: React.PropTypes.number,
    invoice_id: React.PropTypes.number,
    items: React.PropTypes.array,
    url: React.PropTypes.string
}
