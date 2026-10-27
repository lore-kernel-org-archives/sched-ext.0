Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793100073;
	b=l+94sKzo2oTnMlvnWCZ9GeIvlXRcdbXzzNEoTf/BKwJ/9PtXpcw7FK5OomlDus34lU9T
	 bETluxW5ld4vq9ux9ql1mRovHp7UOI5YIWObNcQ/XoAgrAXFBa18Ki4cO2U28PL+Rp1tT
	 ZcBhMcpDLXm/Nmp09nr+ggnxUtngNLPG9fxe54zvkEGoBOe7/bjhmFw+yoRfzDbZugz8V
	 Pce3LqRiZcxZFmh/CNP5zVvzySR+N4Kt8i5F/0pxFjKtx78599MKNLbuSPX56ScJzWxRa
	 n4cUxvtFxmyupCyQPpdveXBdfvIhIutUDWACOUpwoySmWbNf7Kw7jQ6J3uIwY1iihKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100073;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TKJsdbzSF4I69J+kllD9ThTFYWQKw0Yz2k8aE4CflAM=;
	b=fDnve0lPU5M5179XnTKRkJTfLWBOvO6L86dl5x7dHNfeB+KLPV4LZxu/vL/GDtHNp5bA
	 6Xd/RMGGT8O3lSc8ORU3LCx7bUsATy8qilBzi2/EV2/vXpkfO1tsLsN245VAmfmyPjpzK
	 mWplW668q92jG7uGiDv+swpWvvMLQWGUIyflS3ykvApY3wKgA9fUzlxbKfaoqHvihmngu
	 UrEwqrEmQMOeWRv2QBDjY6cKIxoVXDWE5K9sNaPQoYANDboIrhn0PZvM0nvoweduYlvP5
	 nGhdtEGraofyVHkdA+vIfet+981CKyIItH8GgA0H8SVeegVNC57i0OCa4oxi0HRl8AA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CqrWQ6bP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.37
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386D606A32C
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 11:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7386D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CqrWQ6bP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQwz5GMCB+uye8eFyBXtacyV6vgSPJP/ZQOXa4wqQWi10fQVmTc4tSToJMMMdJk7TdRxDF1yL5taHpvx9TWJZBVsZatmys5wDP29ai/W0kVWFZzLIQ66IAeQjhCm32qJJ+LIcV+uIxqbBzj7H0GPnDtvEd7okiNM+LvFaELmFNCkYGW83+g14At6Ah+W6L2AEZN2sQPW+seE71ZJeT/DhCvxb3HhyirnCA1LEI6ZVJijlujTY+mMWcVABJEaOJyjcpayZUUrpyclP1i22eJsDquFOb2PspS2WOoe5TsS7Bxc8N7USuTP1PW6s0Uh9PkW0aq8F5Nq9ywqkQ+OHqadjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKJsdbzSF4I69J+kllD9ThTFYWQKw0Yz2k8aE4CflAM=;
 b=p7swNa3zrQU+e+1tf5di1LWbesXuDizpt1aK2VJ43J6UarqMySsCY5fxWzjY0A4MEs1YDMD5Lb/m6GBCHXmjlmcBxcHqa1c7KUg416O9hoBr4k9+Wb4GHEXO7Fa0SggokuNfMUyjXO57l+EEkrV4Os3Aq48SKEKPsxJoWRsujfv00dm57JC82RF8BVCw4vrEouQhClj5PJuZVDLHQQOfAM6WmgAnerXPnQxQMd7xtX4ja059yTwJG6CwgEvlm6Ixx5cD6TuWHQFiiTFrPe5R5xZr1s3AymwT4muUEQRFB2cfGL/ZAYGDVUmCh3jXFS8+0hrxq4uEcy7iZRlyhHAxXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKJsdbzSF4I69J+kllD9ThTFYWQKw0Yz2k8aE4CflAM=;
 b=CqrWQ6bPiTlZ3kO20WOPzzdz5BGoY+1frx2ooRtsO8gCGyITD36YjkfsI39/FNNM8A8bHk5JghN18pn+aFvBRwQ8DdBXmHg6276Z5nsGf5B2M5OqrE3tvS4vVSlA+SO5GEi9SBWgS3rRo9u7cKj1aZthc50amjMEAsMhQt8w4aBlgdRAAGo81MVdjIlgK0Xp1CY35msiokI5lRf1h7GdGHYXG9WEUMVPjQVJ+aQaj+MxqadpqAjY+vvPo7MMfwKeFoBLTeHwjvwMam4cwrv3PLRvJZG/qWo/SNw1sYDwYlUlVVto8GJ1Ilwqo2JdMCnKqtNf7rGLI0ZuBVRcclt33w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Tue, 27 Oct 2026 11:21:05 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 11:21:05 +0000
Date: Tue, 27 Oct 2026 12:21:01 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>, David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>, Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sched_ext: Add a kfunc to read a task's preferred
 NUMA node
Message-ID: <auCJHU4_ugxayy7i@gpd4>
References: <20261027041536.3317971-1-arighi@nvidia.com>
 <20261027041536.3317971-6-arighi@nvidia.com>
 <cf3e5585-128e-4ee3-9352-afbddbfd50c1@amd.com>
 <auBLYFDJ88gTxtLM@gpd4>
 <20261027105056.GE2668564@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027105056.GE2668564@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::27) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e974214-875f-4c5d-7faa-08df341c63ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|261026140227099003|56012099006|4143699003|11063799006|261022075727099003|261009223027099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fi4okWxpepH+TvwPEAsY4SY/hUQIR4+t66VJnGduj36J50RXdFtgTkxE2nVduspZRPt0Czc2GpNmIp7clv5Sjn6ebzN71dZnlxi+LgRhJkdNxzIwMay5s4V04X8vKfkE1/WfuughEKWn4d85o+IAKmrbAVGYhGRcSb/EJ9U64Ki0YYp3J3ezYxhVe4342YntBNGdDFTLvMzZ39Ww8ofnn5e3go3KE4s/OAMcH3U58Nd6nZ5j6XiIpJLPa5DyAMOHwc3OReSDbjyuFuOeb7GZoNF2BEO+sYQYNCrRus5UEahHULHJUlEonn6e3TwgOzFFenKUjYJ3GxPmDJf66S1HoDa4wSEnMIVKiaif8kSxnF8PeiyMJyEGbKlYDlMp1Sup+n+K2bMajtFndnGIwgfACYUYWGs0J1MfVNNMZIGX9XohbjmL4o4YdrrvxL130j08ASMcQiPK49d3+/p3TJufjUXKMEe/HnvotXCSH3+nNhbESK8MzJZfufakjlqLAOWULG3McpZs+zmeF9AL6yALbxCeLDcovLiZL5QJPa6ytAdGovkjJHmM5ODvxq5KJXz3b0dJXkh4MPucHEZRbsvkA0NVyaa3VmrOUxWjdYthpN2dLlIioOorzf6Py5N36WMHSqB74XWB/Rxj8VEwsTyzo/1V+ac/rU7+l3Hs2vgYJ0w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(261026140227099003)(56012099006)(4143699003)(11063799006)(261022075727099003)(261009223027099003)(261022105027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7juB1Vh/kq5itj3jvksCvaOoVJuVyTKRYLqrGtsVouFcUMUp/m+22xReMChW?=
 =?us-ascii?Q?DZfC+29xfTkX42XFV1gf2B1dG3qNyUEWpIUYr5y1Guw1Jt/m/tw59R5/W1SX?=
 =?us-ascii?Q?Tnez1FES5RLAEMWHxkT4LLxqcGFtpDhAc1VhHFeC/w8HmYoNncdgGKbfnJ10?=
 =?us-ascii?Q?R1ef/xgNBUAtvrNfmfeU6csiwpkfzjz4KDPc2FoSmpkaOwoDsxaiQWu9uVNK?=
 =?us-ascii?Q?vJiTzx5yWhBcxYUjvgAACdAlacP8bHKfVxSMDrRcyy1YXhxGuIl4XmdABsT7?=
 =?us-ascii?Q?PKwKZOc2R3NyDo/riR10ppD49qnGdO02OHR88iPkJEJu4Qky9xSM0kh+hJUB?=
 =?us-ascii?Q?g1nk+hsh1y0UI21/rtj6eslo4S2JvT/u3co0Vu4aBu+6FD28BR7Kl7ullUpF?=
 =?us-ascii?Q?r3Xb93kvVaqjxJWCLeL8tNwOTz3gHU0b+SgPRWSpDu8dFU/cnGlk9SS6TKZi?=
 =?us-ascii?Q?b+t0E8gRCCE/Vk0wW7Vri1ZMdT05WXFu72ZuMpaLLDZE2tIlWY8GinWW277E?=
 =?us-ascii?Q?Ex9pxPqRQjY5ZRMqVJ9OCapkg2+yCxPp8Dr0pzjFC8nMGTj/8W+peBl77Xv3?=
 =?us-ascii?Q?6hWTMX/U1+aSY9hl6mRJddlypfWDmMvbe2r6X7S9Rab+6Y0kYjhChQO46/Aj?=
 =?us-ascii?Q?GBCTUN0ib8xMIh3CeHXcbfHsD8ZvKgIPwy7NmXpD+Hq0/Twf8Z9AQLAPOx3+?=
 =?us-ascii?Q?Nod5Axd4yEV69cxKTadb9Rfsdet/98IZAzm2gjeFC89bRIotv5bwkVY/wSEL?=
 =?us-ascii?Q?XyGc6duD0VuaVxgKvfp9Qr9wvmOadF5Ajg8Ka6szEI1sHFKXbHd5KqMpB/1Z?=
 =?us-ascii?Q?awOLLKlPDydFP6Lkor6EbIIvcM4UXkCZqs+ppsKpQ2hCaXIALiNz+ADRb6ZJ?=
 =?us-ascii?Q?LECdYcpxUMhO0yu4CtlpuV2qYO8vnSA9b41Autw8Q/NchVzQmvovvFFBLbyS?=
 =?us-ascii?Q?KThfLThc2AEwQ2ofFvv6VloZQv3yuM8h9Q6E+MBzQnWBs4MhDnPQ1YE9i+uE?=
 =?us-ascii?Q?psJphNgNxULZOnuiBoCPI2B2WCcJfIIPp2wNkVv/gD+emkZcu/rGQRMw003u?=
 =?us-ascii?Q?+sDxE19Ro7uf7XwroPvsn/kMLDv+688AaIhfhaAwou0QqXlRMkrwGm52R50F?=
 =?us-ascii?Q?fX9xaRA0TbbG6FMqEpiIrqA0PFlX92Oo5wSux8zHZbU7nnCYRK/VyE4A3zUY?=
 =?us-ascii?Q?azQhMQKFcCVaBqEfORWhmYp7HmnmQqQLm4eTHbUZE7v8WYz3S+HLWqn0bqUU?=
 =?us-ascii?Q?mPVpy9ulmzIHNLOiHEGziZIXDDlDUWwK6qSQGLQ5q2CLybxAEB6rlmXD2uJN?=
 =?us-ascii?Q?aqdRkqpClpm+75dd3M589xNXCozfICQEG+j36BposMMwMCMxyCru+YgB8vcU?=
 =?us-ascii?Q?J87tDcGQkb40kl9NGvH1UJW6opAs44guMdBUQlfdPXaphLiT7FqzGaHkM6e3?=
 =?us-ascii?Q?yy9NAqzElFj5/hmF5ljLzAI6SS5pkO/2P34Qj6rXz/4++DM+MmP0DsgozsNW?=
 =?us-ascii?Q?xmnx1ekdLZv77mAiJ6yML0V6IQW3IP7AEdoKPSzrqLEOoq3xekIgWjdYNBmV?=
 =?us-ascii?Q?oLMFuXuebzZ66zGvN57jWAESO5XwDCp9STCqa3fY8wrzDoeG525fP5Rq+Qj5?=
 =?us-ascii?Q?rBHmeXXqaPnnu+QlAe7KT8tDTgfP1c4TrAk3ty4YZ6j/Ay2ilgkYFBr9TAhX?=
 =?us-ascii?Q?xSCD099oPqI6bS6ZmVKWNJLx90F5c+i1DTrqlBzCQEcodlNBnYq9VOWS8oRc?=
 =?us-ascii?Q?x/5WJxm+UA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e974214-875f-4c5d-7faa-08df341c63ae
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 11:21:04.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyvrvY6bDi4LELantBC3nGJoGyqgFk64J0BGbgM7esknNhE6xd85/o3FDv6u7pxYEl3AMjy+UwldHnJTP2TSkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021

On Tue, Oct 27, 2026 at 11:50:56AM +0100, Peter Zijlstra wrote:
> On Tue, Oct 27, 2026 at 07:57:36AM +0100, Andrea Righi wrote:
> > Hi Prateek,
> > 
> > On Tue, Oct 27, 2026 at 11:42:22AM +0530, K Prateek Nayak wrote:
> > > Hello Andrea,
> > > 
> > > On 10/27/2026 9:43 AM, Andrea Righi wrote:
> > > > +__bpf_kfunc s32 scx_bpf_task_numa_nid(const struct task_struct *p)
> > > > +{
> > > > +#ifdef CONFIG_NUMA_BALANCING
> > > > +	if (task_on_scx(p)) {
> > > > +		struct scx_sched *sch;
> > > > +
> > > > +		guard(rcu)();
> > > > +		sch = scx_task_sched_rcu(p);
> > > > +		if (!sch || !SCX_HAS_OP(sch, set_numa_node))
> > > > +			return NUMA_NO_NODE;
> > > > +	}
> > > > +
> > > > +	return READ_ONCE(p->numa_preferred_nid);
> > > 
> > > Would the ext scheduler need the raw numa_preferred_nid when
> > > sched_numa_balancing is disabled?
> > > 
> > > It may just be pointing to some stale value if NUMA balancing
> > > was disabled at runtime right?
> > 
> > Right, if NUMA balancing is disabled at runtime the value stays at the
> > last preference.
> > 
> > This is consistent with fair: disabling NUMA balancing at runtime only
> > flips the sched_numa_balancing static key, p->numa_preferred_nid is
> > never reset, fair stops acting on it in most places (e.g.,
> > migrate_degrades_locality()), but not everywhere, find_idlest_group()
> > still uses it in the slow wakeup path. So a BPF scheduler sees the same
> > value that fair keeps and can decide whether to use it or not.
> > 
> > A more accurate approach could be to notify the sched classes when
> > sched_numa_balancing changes (e.g., resetting the preferred node of all
> > tasks when it's disabled and recomputing it when it's re-enabled), but
> > that would be a significant rework, involving fair as well, and it's
> > outside the scope of this series. I'd rather start by making ext
> > consistent with fair, and then rework both in a more accurate and
> > complete way as a follow-up, if we want.
> 
> But should we not cleanup first and then add shiny on top?

Fair enough. Looking more closely, I think there're only two places in
fair that still use p->numa_preferred_nid when NUMA balancing is
disabled at runtime: find_idlest_group() and the fbq classification in
the load balancer (via rq->nr_numa_running / nr_preferred_running).
Everything else is already gated by sched_numa_balancing.

Assuming I'm not missing anything, we can probably add a preparatory
patch that gates those two on sched_numa_balancing as well, then make
scx_bpf_task_numa_nid() return NUMA_NO_NODE when NUMA balancing is
disabled. In this way the stale value is never used.

Thanks,
-Andrea
