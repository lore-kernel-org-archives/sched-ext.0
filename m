Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E462C371CE3
	for <sched-ext@lists.linux.dev>; Sat,  9 May 2026 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778363006; cv=fail; b=hAN7bk5Fyx/EgKTgWwsGw0//pNpOl4dsr/+nM+PAXCTl0j0xop4iL+A0CSMF+nwAEp99al27ve3h7P0xfrnt/7WDScdm+K1mJCdq7Y6ntwrX2R3L+hGiIdguhk/AhgJGev3yUK+FCuwOvFoyD5KDvmUpMrUpMMoQB2EPYF6toO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778363006; c=relaxed/simple;
	bh=15E/HjvyC5mnOs4CeANKE1uix69sLhSUB3Lz5gBH/PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bzhYQ+ANrAw94WEXpDO4vaJjW56NQKEMSGOSRvqyPo6IkmKG1/8MZxW17iAeyeVD+bSg8e+sKfa6yLMMHpAxRE1ZobZ1eyBwU6xz0wX+skISMiNLS0RcT8GKKuxtFUa3IIYhCwB5zOpBlHJYnxb/9GyZ641yKwdaNhSxob72kUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UXRI966l; arc=fail smtp.client-ip=40.107.208.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UXRI966l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LClnJsxGk12NmiEWqdZzqLnfPuuOGHrdJRSusVzvw0WIbth7aitWf7D7XlqcEoubWveZ/HRynZZcAmxpIIn1ojIYKVLoBnh6tijxMSSstL8V2JkcDK0vGBUsDAmtAXgj5hMonk0CYZB/LwNVG1AL/JwPRMyQa3SQh8vU0KbgI519fcuCXRwIbrn9PPbI6ir9/s6HrxR/COEB7ueLjQhZyJ7QN8TTlWneLwYABd0Ni5wFcGuGXuMAw36pux5BQVbM9WOhY9JWB10eykPrRF+hGmlkjJDZtB6mkISfrI8OUvy/6k8xTQq6oLZSPX1SG+FJ/tp6fN9y1bQgzMh6K73OcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wCKxoVkV78AXt/esKGCPp0C6hqiHOQeQSNm4iUgA7A=;
 b=Ldw9YIrbhgT7SMlgrIglikBUXaxlEaaLMfgslemxcmyy8kYgM/SHhg350cNnnkdyEvW20CxdP8x9VPDQZ+NNWnm7MkOAkazJEuvEORRJNs6pr1J7KULV2B7R3ueH6PTPCIel3cqK/fU6YHDBtf8M8xSfSRgkmboTzzBPkQCY7LfE/Tak1e17V5CDcNFHnTjsKWqWw4C/cXY8U1u3vgV35U85II7gmfqO1o4+0tPVJCY7i8CZqLPrHx1eM772JS9dUG/jwTnjvG/oF4RreyICGBhwQUmqNj9+9dR2ZhJt4k68KN7s7H2XM6mwyTvBLmt4g5SV3pi9C4MiuIP7PseL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wCKxoVkV78AXt/esKGCPp0C6hqiHOQeQSNm4iUgA7A=;
 b=UXRI966lWaIvJqfjjjJqRE/n+whLTRzK6SUr9y5EadfUhwh8A2B0hKgf/KUrtchuEnbGL8OBQTtHNskv0+h4fZz/GCVKbKV017l7s7c6JxUdaqlsFl5SmoIrVqvB8vW8R/rG5cot+Vcnk4VRgz3q6pBVRXY/vhY2bmZ02QPuaH5D7fmgpSo6qsoDWzakJ0HG+aIxlmxCnJPpLfHafIPCgNBtRcxJeSGQexQppqFskJdYMK2d1NNyRE2W3apBOWMD7jgLOB9JEyHvnfamYFXkZqrk5FSpdAb0IZs/WL/fVCNJVkVzzdN1JL0pp6fJSlFRfJ/6BrwZTl0FP4O81eF4WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Sat, 9 May
 2026 21:43:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 21:43:18 +0000
Date: Sat, 9 May 2026 23:43:07 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/sched_ext: Add dispatch_cookie test
Message-ID: <af-qa9u5S9NJdWR1@gpd4>
References: <20260509191223.168648-1-yphbchou0911@gmail.com>
 <20260509191223.168648-3-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509191223.168648-3-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI1P293CA0022.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH1PR12MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: f98c1fd4-f787-45b4-58dc-08deae13fa75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KDCGMZkIxB9eHmAsxO58+5XTF707mbIUv1xPZULXcQVeRerl5StmbsYW7sjaw0mIA/iOCVoRNddzr6UeD1btAJMhEX+kMHZ7adNHlRD6Zxv/0Fv2onSoEDURvivdjpFcxKJ4rSzPbKyL1wEKzJHxbBZsrdDpjoFqG32ObwAIA4nmXs0E7B9HRL4CIxtM0rXkUAetJUPULHhGBr4wCtZ3xu6ny+chc0Fw/h037vzsc/yXmQs+tnvzWKMMZNisDoKTHmasv0xnDp/n+P/GNYp/9O0FQLE70F7ZzTgqZuOXhZT5Cryg4a2hPUh07sdPy80YEtavsspHiKx2WtHKYPyJnmIfGkemz7+Ot+mftLTenMMcjuikioRhxjH/f0rNFKD7UN3N0cf4VSq981I7pmFltf8iX3ldjSmYSaE6wbnzimhskUnoUVHcVkCLNz8xGiOxL/ac2Ld3Vj5W3PI7dYkSDUzax2mDPN3a3q9jzjKaR0pH08M/Ae9pXgFliRRJk1S5okVLN5/NIH0H+RDWeGsusJFoUULmzJYJzltPuKig/roSAIoOV6npZ3QO6PByYHagGQFT+KJJ7aRHrjWP96pgSc9vVTgn9v7nub/EeXCE01SEVRSfNh2rHT/5K5qttGW4IBpX9v/AbTntn4E2yW2WMy6pSvZxMw5H6wJ7rWS8aUh7hTBe2FyEjXrdrZInDvPI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lZGdx+UyAJzbzhCw0v4JqZaMaBSBU4EnGnrwzxaxuF2uLTafDBNp/vPFBAP5?=
 =?us-ascii?Q?uHXW8005rZgn7Oi8Rpk6aGrTQL190Qh36+mq4jz1uPPwlw3MTYQQrUusJd/N?=
 =?us-ascii?Q?/qhXPz61pCfBYLnktaKl2lM43WkGXGtdaWcT94qkdy8Q4JDb8b6S8eioRxOV?=
 =?us-ascii?Q?coNhLIg0RXBL++LOUgPNwKtxUUciOLBRSWAHkNNwq8ItBJTCCnH/dIimoR6t?=
 =?us-ascii?Q?Q/yngNoaHwfTaxRaEjQZ9KSsZ1RIzb4zu2XtQXCb4XvAMF/FfQI+c9grn6wh?=
 =?us-ascii?Q?dmvgJONudRVo99aN6Aw/+kweY7F6rYjcW5f2l5R/2X9q6L6OcWXtWL4jDV+r?=
 =?us-ascii?Q?BvoI7qnNV5tTw7HZuw6dbr10m2p38+lLRUd7832mShY4W9plZmkQOYF4Va4/?=
 =?us-ascii?Q?jov4cOK81xSKHtFBF9RwRvVKKejsd4pedaLj6yXILO5Ho2qCtsC/XI6XGSPu?=
 =?us-ascii?Q?tiMH8D0x7Aii8I4Q+0YSW3yq6LzxNQroyPqbs6DYM3dugQTTJ3lITWHh6TUn?=
 =?us-ascii?Q?/wryathTlGLV3syTRJVFBwrG7AijpumrD0Vd/RYVhGaE3gdQKu9gi22lkyIT?=
 =?us-ascii?Q?VdeMOcQaBYT51SAk95ZpbfJxUkBsHd8uyA+zici89e46IzPfWuyJPQKuf9Bc?=
 =?us-ascii?Q?A3mSUcpNhQkBInDzMrtTgma08xXY/fO+mwvKta7MTTPNZ315i+zWCbK88Nn7?=
 =?us-ascii?Q?2+NFuk8FkcqfpX9vfjSTH+lGlFT2XXa5hl1BcMCEuPPIZNIBCghxDjMf7bRG?=
 =?us-ascii?Q?WIec1I1/XqXaX0DYbMrgpn6VHtBroY4iZhF8RjT656h5jgBeKpGUr9CwBfQm?=
 =?us-ascii?Q?0NAXiF+LJPETArjacGEoqtddd0oy+D4tTfT4+MuvtMFS4tUk1HzN6U3oQDRc?=
 =?us-ascii?Q?VR96WhmHMZU9d3C1US1UzllEGkT6OaJq1dtA5MDqglCw2z4WJzO1Mp7rvLzy?=
 =?us-ascii?Q?2i9epsKtoUh0N3a9dPKUgVe0RbDyZ1z5OGbE7eIXZwiz0DhnJM5ZZ6nEqGWl?=
 =?us-ascii?Q?Y4d7YUL5kVj17b3B3f5Rc4aMYaxj/8uAuqwFn9+eoKM+36mNeMOIsKh5+rwM?=
 =?us-ascii?Q?oxI5c/GQG9k6k9UCO+V1IXK48j6O5rUTingShw4VcrwaJySmgldVYJQB1l0v?=
 =?us-ascii?Q?/yCbENiUfDuAm+Jp+0hMyUMU7xvL64BFgIhdNGQm4BCdOq83ARz7GcxI96Rd?=
 =?us-ascii?Q?bqxNa04xuhdFQRtmDwi9WJ8xs/1Q0ryl7WIF6chyrs+j1lU+hjdpqqdBJ4Eu?=
 =?us-ascii?Q?5BdV4ypfZf9Hb17Q7g67857/OSJvOtOZInrafauRntI4SSb2HEgRNSou0YrN?=
 =?us-ascii?Q?V43Nx2tnHkhQ2BZhiIGIjGHjz9WICkYJ1a7cbr5v+7oEuydu8yFxYs+sSIVU?=
 =?us-ascii?Q?XSLnx9iOW1kLJL/QOkpgyCID/7VShTXpXXAyKIGpV6VCeAIU+6fSKIAi0gKU?=
 =?us-ascii?Q?IQZK7Hre+5zzxrtmMtzl0U1d4psGqHWr7KwYqFK3IyRgIxUPVzjJ4icIki0T?=
 =?us-ascii?Q?99MWxnBwDxY0D3eRmMknTQaYC1UT0610xJJ95SG3L5FHd0pjgSvWujV/0SUQ?=
 =?us-ascii?Q?nKZyHNUXFAplJONFzRDQOb2jw2YQ8BbVX3JcTUv2p9Csi7NdKa1OVSl7ZnNt?=
 =?us-ascii?Q?s78WEflPtO1JSeZM1CIbNOlcEnv+tCbQLJvtd5s5ahyuOt1IuxRjapgU2cRR?=
 =?us-ascii?Q?5YqhqhmCTXtjeZRIBQX8xhGsAgx3idFrE9H++5UVIPu/ODvtHsb0Yqek1Guh?=
 =?us-ascii?Q?aunOJDpWKQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98c1fd4-f787-45b4-58dc-08deae13fa75
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 21:43:17.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icP+zE9dmt0KtI+fCm4HR7g1IQ+eLuL/ZrE77bm35Y7EZRX7FpsQWOrEz3yEyj7V7xPrHbuhiZqIws1gCD36Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9573

Hi Cheng-Yang,

On Sun, May 10, 2026 at 03:11:57AM +0800, Cheng-Yang Chou wrote:
> Test scx_bpf_dsq_insert_begin() and scx_bpf_dsq_insert_commit().
> 
> The BPF scheduler enqueues tasks into a BPF queue map in ops.enqueue()
> and dispatches them via the begin/commit transaction API in ops.dispatch().
> After a successful dispatch, the token is stored. On the task's next
> dispatch (after dequeue/re-enqueue increments qseq), the stored token is
> stale and finish_dispatch() silently drops the buffered entry.
> 
> Userspace forks spinning children and repeatedly flips their CPU affinity
> to trigger dequeue/re-enqueue cycles. The test verifies both nr_tx_dispatched
> and nr_tx_stale are positive, exercising both the happy path and the
> race-detection window.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Kuba Piecuch <jpiecuch@google.com>
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
...
> +void BPF_STRUCT_OPS(dispatch_cookie_dispatch, s32 cpu,
> +		    struct task_struct *prev)
> +{
> +	s32 pid;
> +	struct task_struct *p;
> +	u64 *stored, token;
> +
> +	if (bpf_map_pop_elem(&queue, &pid))
> +		return;
> +
> +	p = bpf_task_from_pid(pid);
> +	if (!p)
> +		return;
> +
> +	/*
> +	 * After a successful fresh dispatch, store the token. On the task's
> +	 * next dispatch (after re-enqueue increments qseq), the stored token
> +	 * exercises the race-detection window in finish_dispatch().
> +	 *
> +	 * scx_bpf_dsq_insert_commit() always returns %true when the preamble
> +	 * passes. Stale detection fires asynchronously in finish_dispatch()
> +	 * with no BPF-observable signal. When using a stored token, always
> +	 * pair the commit() call with a fallback scx_bpf_dsq_insert(): if
> +	 * the token is stale, finish_dispatch() drops the first entry and
> +	 * the fallback dispatches the task. If the token is still fresh,
> +	 * finish_dispatch() dispatches it and the fallback's CAS is a no-op.
> +	 */
> +	stored = bpf_map_lookup_elem(&last_token, &pid);
> +	if (stored) {
> +		token = *stored;
> +		bpf_map_delete_elem(&last_token, &pid);
> +		scx_bpf_dsq_insert_commit(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, token);

I think we should pass 0 instead of SCX_SLICE_DFL here:

 scx_bpf_dsq_insert_commit(p, dsq_id, enq_flags, token)

> +		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
> +		__sync_fetch_and_add(&nr_tx_stale, 1);
> +	} else {
> +		token = scx_bpf_dsq_insert_begin(p);
> +		if (scx_bpf_dsq_insert_commit(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, token)) {

Ditto.

> +			__sync_fetch_and_add(&nr_tx_dispatched, 1);

Also, stale detection happens asynchronously later in finish_dispatch() with no
BPF-observable signal, so commit can return true here and write the buffered
entry with stale qseq=N, but the counter is incremented before finish_dispatch()
runs. Later, when finish_dispatch() processes the entry, it detects the qseq
mismatch (task now has N+1) and silently drops the dispatch. So nr_tx_stale
counts "attempted stale commits", not "detected and rejected stale tokens".

> +			bpf_map_update_elem(&last_token, &pid, &token, BPF_ANY);
> +		} else {
> +			scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
> +		}
> +	}
> +
> +	bpf_task_release(p);
> +}
> +
> +void BPF_STRUCT_OPS(dispatch_cookie_exit, struct scx_exit_info *ei)
> +{
> +	UEI_RECORD(uei, ei);
> +}
> +
> +SEC(".struct_ops.link")
> +struct sched_ext_ops dispatch_cookie_ops = {
> +	.enqueue		= (void *) dispatch_cookie_enqueue,
> +	.dispatch		= (void *) dispatch_cookie_dispatch,
> +	.exit			= (void *) dispatch_cookie_exit,
> +	.name			= "dispatch_cookie",
> +	.timeout_ms		= 5000U,
> +};

...

> +static enum scx_test_status run(void *ctx)
> +{
> +	struct dispatch_cookie_ctx *tctx = ctx;
> +	cpu_set_t cpuset_one, cpuset_all;
> +	pid_t pids[NUM_CHILDREN];
> +	int i, j, nforked = 0, status;
> +
> +	tctx->link = bpf_map__attach_struct_ops(tctx->skel->maps.dispatch_cookie_ops);
> +	SCX_FAIL_IF(!tctx->link, "Failed to attach scheduler");
> +
> +	CPU_ZERO(&cpuset_one);
> +	CPU_SET(0, &cpuset_one);

This is probably fine as it is, but it's worth noticing that if for any reason
CPU0 is offline the test is probably failing.

> +	SCX_FAIL_IF(sched_getaffinity(0, sizeof(cpuset_all), &cpuset_all),
> +		    "Failed to get CPU affinity (%d)", errno);
> +
> +	for (i = 0; i < NUM_CHILDREN; i++) {
> +		pids[i] = fork();
> +		if (pids[i] == 0) {
> +			while (1)
> +				sched_yield();
> +		}
> +		if (pids[i] > 0)
> +			nforked++;
> +	}

Thanks,
-Andrea
