Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013058.outbound.protection.outlook.com [40.93.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7465E39C659
	for <sched-ext@lists.linux.dev>; Wed,  4 Feb 2026 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770199925; cv=fail; b=A/SMh8kW/SpX1pPP+CRTnxsROsTB97ZfNWglGjteQceh0sd4Ih/kAsTlFfXe3Y369tr8h0b+4jC66fsRlIPD5aL5gymEmYjXhhbnUERQ2M9V4vKY0DkgQcmUPOggFT2UP2Lmi66ZLx3Er2RzRAFSlK3WqXgqhLHKzxzefBb2E3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770199925; c=relaxed/simple;
	bh=TlVlE/S87pWzF8QFxnu9ZulY1gfOygvV9bi0T4sdqZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r1Ok1faZ3lxKUiRp+V3ZmQ5055kWiznA7qZB634e6di/kdLVtA4+cJSapoLkYMBDRSRi/oOXB9zZKuYC48Jgi64oLhhVMW1AR07N0iCPutAH3TvBPkCh342Kfuj/k4LrQJ2QHamjuF+YqWQLfNxa0KJmVMH+4OhB2k+cOBJ/hTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lv54nTFH; arc=fail smtp.client-ip=40.93.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lv54nTFH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyVRZHNKG3GTYYi+9EiJQD22uXViaBzxQYiAsqJpcSZ56SJdIO0b2F7v5jstRbu2U37rjJhAfSD62Bir5Sq75hTOKr+0MRZhv0ciRYGHFH2MBrbVQh/t14B3cIDIzkf846tH1P1h9xBMh/IPWwlXoscsiydWtnD3w6qDfh0V1TYPjV4j3eYFiAkjcc/nGk3tV7sMLAbfMXUqOZZ9a8/m31hLd0UN4DsI8AO3SPYFDr+i0n/5lVLQ+dGyJLRcmEJn+Ks1OaXZkRMRD0OHSn3KEg/0OK0IAsDvSkY2pdByzVPFbTHnypgj11+gFTn8NeRjX8QosRYjRel+l8C9HW/AwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT4N0nLVB1IFimnltZitq+eLtEdbK9gCg1tHcJ1LPcM=;
 b=YsieSleSCqSqwN+fDRtKysjwi8cWR/lXGzuYX2llHKygXza/uKpRmubgU9tcCah88zINlTXOvC2zIq+gP/ARxr5Kqovi04wKVng19W5GWonfNtvWmOxUZRZwnpt/rdIuYOb8H1VPddVxrAojbc+E8YkEwRnbSRKwFk+u0H2T/WNVgJFSSPOXuCuq1CpHdDwKewYyAkef0pNYPtY75MvGSbvLnhZTKHg0HmR7vcibMS+BtRzTu8qftFCKapiEtBMUX9zK229tewrDdtMnWQxemsLLwVCScfb3jfMkEoWvVHRCJatw26giWR0bbUnTW+k8MhRzybAdoyrM8FyoB/8msg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT4N0nLVB1IFimnltZitq+eLtEdbK9gCg1tHcJ1LPcM=;
 b=lv54nTFHqgHnBS/E4t0cpJVSg6FFTalsUSYHwgd2MSxsho2IF+8bA1luNTd9GqVEZMMZ+o1K6uTcdysen3NxkicQ/61nzTFFsZNrlRQcEQIOjZYH4TCaSv9k9hXnQJX8CK6kVTl/zuhewK2sMQp0H2c91ZdOpLZ8ctc2HGbZRhjlMl9RjDvnYUHtm9/1aZI2rlSlyrFa6wdN2nPw0yuaQ8IDa9WN3YhJ+xcdL7dR31RA0sy+SmgJxu8EJBLskGsEdWWD82kVxebWt6vTkjb6aM5nwfv1jj1HR2YQO4Znvaw+JY1UNd698EC9EI2HPDR9GXNjz6GQ450bCb9A0/PltA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PPFAF883AE17.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 10:12:01 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 10:12:01 +0000
Date: Wed, 4 Feb 2026 11:11:49 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYMbZcRNR5AUNiUt@gpd4>
References: <20260201091318.178710-1-arighi@nvidia.com>
 <20260201091318.178710-2-arighi@nvidia.com>
 <DG4GH47JCNH5.36CX78QFOYVS6@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG4GH47JCNH5.36CX78QFOYVS6@google.com>
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PPFAF883AE17:EE_
X-MS-Office365-Filtering-Correlation-Id: 6672bda7-b458-4f93-94c8-08de63d5d65e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bCGpN18m5qcPuRkkgW/hW4G+t1Nf5ah+UR5dj2VDR4fJUzC+K2DH/1X5rQNL?=
 =?us-ascii?Q?Fbu7+jfrNgP3FlM5Eassjmc/e+4ssMPQ5KC74S54hd2gWb9YWeDKuP65DXa2?=
 =?us-ascii?Q?tmRkQuSpYtr9WVVKhrbquUDTVd6/z2HuLVY01XjHLeY65r/95TW0xpey8JhQ?=
 =?us-ascii?Q?yFvQiN8SBEzyX6QeJu5QxjjKVw9WFgJHWSXMxkCWAxTUnCNzWutsOR2ZH6zs?=
 =?us-ascii?Q?3NxMhP8meKTSkZHXnlwLbtd2gcYRaxKs2LmI3RKh3KwfzCNXAMOszNUkoYKd?=
 =?us-ascii?Q?oGCWscA1KSdh/xHxzJk3s9SqBi17xZ4hacZHN5ZVFB5LapIAos02u9GduNkh?=
 =?us-ascii?Q?2+VePlOLFu893aKQZYZ7u8H6iiCXhAIAzmS3nkZqPWE4K/lutA6G7zj3M9CD?=
 =?us-ascii?Q?ccV6hZfWvJaASpoxuAaDf1OLoCD5WxN3+rc5xdbAoiK1JGQ09CyWD0If8tQb?=
 =?us-ascii?Q?eBOc1GGiHe8uc+KlMBKdDqKbl82O0RDdXi5f5kSU5vNMD62LZ/EviMJDrM9W?=
 =?us-ascii?Q?OrtV4gvisRQ59OqoLIJiaaldzTdNy01BXPhOggfXkSFY7PTNRfmOvrd3xwvU?=
 =?us-ascii?Q?DQZahpFcddUCh5ZJczagj4ItdQd/06fdFByRnFUj7iIpr/QK/LfyyShVXe+T?=
 =?us-ascii?Q?nUV40ygMqTyfUly5gOch2rFk4KLuhXSvMeGiUv3uquyNCAVhlFhi1JONg3Nu?=
 =?us-ascii?Q?jZVUO9g0Orkyv1DQmda+CBjthaJbrWOMzvYjszwQx/uTbQpZO2itiPXXu0G2?=
 =?us-ascii?Q?egaOvbxiJxGv1O1bEpwN0j0Fm4u2jG1dfq7/CEUmA/5EAJUIFDPLfBYekmRD?=
 =?us-ascii?Q?QkuNjU7nGAgXGr5BOJpUAdw0oPIb9Meep4SusJ+vCVgJ7NIt5DRBek5kw0uN?=
 =?us-ascii?Q?zZ1pq8ozITX7xPpc/t0zw9b7Lcp+o6BOiAnuj3LQHvL/BEOd4v0/Xb2K8V3x?=
 =?us-ascii?Q?doPAGtO9JuE7dk4c4tPf9tvLlGRqGCfcQToXJp+UFBTI1/RVN+ABYBKvbWjG?=
 =?us-ascii?Q?qBe02szLX67WyjLI+UA3mcU8Qm5BE51OxL1RKV1NJzLS2bFVcBtk5vCTrUOL?=
 =?us-ascii?Q?AFnjEI5qH7kwlpszXJl5bn0AmdX9ywSJgkxKzlclnDYUywrAZwQ/mVeD2Au5?=
 =?us-ascii?Q?coLI5uRJtYPOtZlSzv7A5DpTb5FgMK+AGiIy6gY1GH9/ve8/uu+WdbF6DDv2?=
 =?us-ascii?Q?jnrUIzelPNX0rWNTd+/9QxQv75v94nViOU0SF+nYf1lEfh8Q2gJkmSq8JjxC?=
 =?us-ascii?Q?eB82BoQnUcvYGGu41KzuVbfv/UjosdIWbPiwvso/Yc+kg+iLEUhjCvn0/jhK?=
 =?us-ascii?Q?gMDdxMDg3D9jSuNWZFjUTW4l+Q6vdy6Swl7f3advJfiB71ih4h41RC83Lc48?=
 =?us-ascii?Q?Iqax2B2hvgrHZSCg7YhF6jA5jKLznQYpUytQgbx7B11wJbSWm46X7Nf8Zh+c?=
 =?us-ascii?Q?D1fqkSmSlsvYAJuzxIrQo+BytISQRGl46sLBUPk4L8gtksR3Tw9Z+8MJKZOj?=
 =?us-ascii?Q?WtWlFlTiOv9JYYGsIN0treGx7iq3d6SnKXVDSiqEGecnxOV0CrJ0cphzUh2s?=
 =?us-ascii?Q?MRidvQghWpEM9O7D2cc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JO+WMgA+A6pkIOTDVS0K2+of2U8qdjfHzJ5K6PGUpSX1Nv/tnu7c8v2c/J50?=
 =?us-ascii?Q?qaTDfdcCFj2tEMfwyzBpn/xatDTjve5k2HR6vLRYmXqbF2bjb+xM8oRNeAVP?=
 =?us-ascii?Q?1xNRXCBuuTmq2hDGyGw4uVNzXIym7xVQSAm3u4a1QQDjA4fJywsK85FegM3B?=
 =?us-ascii?Q?OSAfBYlrW3b7tBTeeYKocMn6cpCpzIGJ2SWN1YdiMSdVZIPBX0brQGN2LZJT?=
 =?us-ascii?Q?J4Ab4doWrHefhR8N+gqzi0XMAIZ3S6X7Xl9H1l8rzJO04frV2xnXLmO2RqXo?=
 =?us-ascii?Q?SQa/GlAOnd35oO7FYhNYb1I4XQZjZYZR+YVbV3mMB0GdDXQRwOWFCnZZ5b9E?=
 =?us-ascii?Q?ZW8wopaYEnQqvuu1cAC7h8MlOCmn39fSOJVICtRlkJ/S4rBKdKjtQPVvttjH?=
 =?us-ascii?Q?MM9fV5SV3mJTEZ5ARrK4u2f5Kg1EIPUZGVGPTPuY/43nceVmr29HDnAzZ23Q?=
 =?us-ascii?Q?d85c+tPLTahItA0FLB9ImZTGymndlCx4dpYO3reQLpKb3z6WhU8WGhwwLt2+?=
 =?us-ascii?Q?vnORKiAvBA43hFFCpUKOL3QVjlHG1nAUB34+mBySws1r5o6H35GmtBnLsnZ1?=
 =?us-ascii?Q?Vhg4LDPXcDPGozhFzUAHyd3pKf0jo+k90FwvsSJBM4asXQ8/CchG8TkfPHoT?=
 =?us-ascii?Q?ME8C80ulkj7P7ch51pul+voVMj7HErNacGQg26idippFbfkBivhXxLcLr2ws?=
 =?us-ascii?Q?l9zIPlyZKjgf2jht2m9lEAAqoLvBMJysqC1E4mVW7M940N9xj1cIr3VAKLCt?=
 =?us-ascii?Q?y4ti7WcY2M2YTQLrHbTstwphlQ5hbU+kekDb2AjLnfqdRkTjR6ZgoPUfkESr?=
 =?us-ascii?Q?Quar0o3+PouV5GApfyPrXLOWcjaAsJN57lWlxEMu0NQM69b6ePElcBNsV1sE?=
 =?us-ascii?Q?m3HajZBqLHiugnOUiaHyXRlERnTtTJPU1xfpFi/ZQ+4LTHNpp9HUjBJa7EsL?=
 =?us-ascii?Q?LnW5ESI4LNa7ERqEo2PqFRO5cVH8zHSN8+mlYSmSNCZzjasyu0A0zCBSOZmJ?=
 =?us-ascii?Q?gT8heRC2IPqLqg/xzFjZ3YBSLH1SZRX8ip4vwDiZw3bm5ozgvnwUd9V4Z2xo?=
 =?us-ascii?Q?8uq+eEyMlON+3NFhhg/O3womlfS85wr0oGs4myvsjXWi5h1MC5f+foHt1RRL?=
 =?us-ascii?Q?68aMEJ5++tF9kp5tCVtwCt2AlFKw3i3tRYoyQLtKJUBqR1tBPOEY6XojO5bE?=
 =?us-ascii?Q?aoJbcGaHgp4nUKIeE39tirJgxnkJFyxdznKC4L4AinbtfOR6Rs9CZ0+VZVgK?=
 =?us-ascii?Q?4ENp3FwPAwZBKqw/9G0D3kFS3gJlMSQdBzFfjE9Fu0X9ZXm07oR3F4sJEsVi?=
 =?us-ascii?Q?mGe8Tb4pJ1MweOodaQxPAxslGddUezYkrwi/mjEAcaK3zJ/GNgwga0+uMwcH?=
 =?us-ascii?Q?6G0svPz3v7/eqyz2aSkGR+D/9eBXdFfy8IGuft5ME2pXlSLVs6P2AetqCHd6?=
 =?us-ascii?Q?5I+1P8mom2bG6GIT134Gut80HK+veX/Ib9vA4tky1g5sb6Ydr0iOGKCep2Ho?=
 =?us-ascii?Q?Cju5aDxVi7MQsT9MetGTVNSsilpwm18WhAI+6aH/8fe3Ko6v6xCYMzjE5tZR?=
 =?us-ascii?Q?4bci7zrhW1kHEvS9ZUSpiztAoUADaMGtO5ueeQqdHyfnzA0icc/tsIGFNnfV?=
 =?us-ascii?Q?5GH0Tp5nz8nAjrmJ8Die8IRZWY41r3vT8TTOLa+zhZjABrteh0wkBEFRwlcD?=
 =?us-ascii?Q?OExBxPKLxNdcDYYK9czehEncMjUNHSt26+HPBEN8wJWH3iysrAKxMchF17yY?=
 =?us-ascii?Q?XWsg+e6ybw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6672bda7-b458-4f93-94c8-08de63d5d65e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 10:12:01.1573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfTdILbCjfzi90UNTOY/gjdv61LXra+F/9XfS0b50FUprbMGf8MPGpK9F4mVxfqAe9PmzGhkZ/l/DPKN6AKQpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF883AE17

On Mon, Feb 02, 2026 at 11:56:43AM +0000, Kuba Piecuch wrote:
> Hi Andrea,
> 
> Looks good overall, but we need to settle on the global DSQ semantics, plus
> some edge cases that need clearing up.

On this one I think we settled on the assumption that SCX_DSQ_GLOBAL can be
considered a "terminal DSQ", so we won't trigger ops.dequeue().

> 
> On Sun Feb 1, 2026 at 9:08 AM UTC, Andrea Righi wrote:
> > diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> > index 404fe6126a769..6d9e82e6ca9d4 100644
> > --- a/Documentation/scheduler/sched-ext.rst
> > +++ b/Documentation/scheduler/sched-ext.rst
> > @@ -252,6 +252,80 @@ The following briefly shows how a waking task is scheduled and executed.
> >  
> >     * Queue the task on the BPF side.
> >  
> > +   **Task State Tracking and ops.dequeue() Semantics**
> > +
> > +   Once ``ops.select_cpu()`` or ``ops.enqueue()`` is called, the task may
> > +   enter the "BPF scheduler's custody" depending on where it's dispatched:
> > +
> > +   * **Direct dispatch to local DSQs** (``SCX_DSQ_LOCAL`` or
> > +     ``SCX_DSQ_LOCAL_ON | cpu``): The task bypasses the BPF scheduler
> > +     entirely and goes straight to the CPU's local run queue. The task
> > +     never enters BPF custody, and ``ops.dequeue()`` will not be called.
> > +
> > +   * **Dispatch to non-local DSQs** (``SCX_DSQ_GLOBAL`` or custom DSQs):
> > +     the task enters the BPF scheduler's custody. When the task later
> > +     leaves BPF custody (dispatched to a local DSQ, picked by core-sched,
> > +     or dequeued for sleep/property changes), ``ops.dequeue()`` will be
> > +     called exactly once.
> > +
> > +   * **Queued on BPF side**: The task is in BPF data structures and in BPF
> > +     custody, ``ops.dequeue()`` will be called when it leaves.
> > +
> > +   The key principle: **ops.dequeue() is called when a task leaves the BPF
> > +   scheduler's custody**. A task is in BPF custody if it's on a non-local
> > +   DSQ or in BPF data structures. Once dispatched to a local DSQ or after
> > +   ops.dequeue() is called, the task is out of BPF custody and the BPF
> > +   scheduler no longer needs to track it.
> > +
> > +   This works correctly with the ``ops.select_cpu()`` direct dispatch
> > +   optimization: even though it skips ``ops.enqueue()`` invocation, if the
> > +   task is dispatched to a non-local DSQ, it enters BPF custody and will
> > +   get ``ops.dequeue()`` when it leaves. This provides the performance
> > +   benefit of avoiding the ``ops.enqueue()`` roundtrip while maintaining
> > +   correct state tracking.
> > +
> > +   The dequeue can happen for different reasons, distinguished by flags:
> > +
> > +   1. **Regular dispatch workflow**: when the task is dispatched from a
> > +      non-local DSQ to a local DSQ (leaving BPF custody for execution),
> > +      ``ops.dequeue()`` is triggered without any special flags.
> 
> Maybe add a note that this can happen asynchronously, without the BPF
> scheduler explicitly dispatching the task to a local DSQ, when the task
> is on a global DSQ? Or maybe make that case into a separate dequeue reason
> with its own flag, e.g. SCX_DEQ_PICKED_FROM_GLOBAL_DSQ?

And I guess we don't need this if we consider SCX_DSQ_GLOBAL as a terminal
DSQ, because we won't trigger ops.dequeue().

> 
> > diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> > index bcb962d5ee7d8..0d003d2845393 100644
> > --- a/include/linux/sched/ext.h
> > +++ b/include/linux/sched/ext.h
> > @@ -84,6 +84,7 @@ struct scx_dispatch_q {
> >  /* scx_entity.flags */
> >  enum scx_ent_flags {
> >  	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
> > +	SCX_TASK_OPS_ENQUEUED	= 1 << 1, /* under ext scheduler's custody */
> 
> Nit: I think "in BPF scheduler's custody" would be a bit clearer, as
> "ext scheduler" could potentially be interpreted to mean SCHED_CLASS_EXT
> as a whole.

Ack. Will change that.

> 
> > @@ -1523,6 +1603,30 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
> >  
> >  	switch (opss & SCX_OPSS_STATE_MASK) {
> >  	case SCX_OPSS_NONE:
> > +		/*
> > +		 * Task is not in BPF data structures (either dispatched to
> > +		 * a DSQ or running). Only call ops.dequeue() if the task
> > +		 * is still in BPF scheduler's custody
> > +		 * (%SCX_TASK_OPS_ENQUEUED is set).
> > +		 *
> > +		 * If the task has already been dispatched to a local DSQ
> > +		 * (left BPF custody), the flag will be clear and we skip
> > +		 * ops.dequeue()
> > +		 *
> > +		 * If this is a property change (not sleep/core-sched) and
> > +		 * the task is still in BPF custody, set the
> > +		 * %SCX_DEQ_SCHED_CHANGE flag.
> > +		 */
> > +		if (SCX_HAS_OP(sch, dequeue) &&
> > +		    p->scx.flags & SCX_TASK_OPS_ENQUEUED) {
> > +			u64 flags = deq_flags;
> > +
> > +			if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
> > +				flags |= SCX_DEQ_SCHED_CHANGE;
> 
> I think this logic will result in ops.dequeue(SCHED_CHANGE) being called for
> tasks being picked from a global DSQ being migrated from a remote rq to the
> local rq, which, while technically correct since the task is migrating rqs,
> may be confusing, since it fits two cases in the documentation:
> 
> * Since the task is leaving BPF custody for execution, ops.dequeue() should be
>   called without any special flags.
> * Since the task is being migrated between rqs, ops.dequeue() should be called
>   with SCX_DEQ_SCHED_CHANGE.

This also should be fixed with the new logic, because a task disptched to a
global DSQ is considered outside of the BPF scheduler's custody, so
ops.dequeue() is not invoked at all.

I'll post a new patch set later today, so we can better discuss if all
these assumptions have been addressed properly. :)

> 
> > +
> > +			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, flags);
> > +			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> > +		}
> >  		break;
> >  	case SCX_OPSS_QUEUEING:
> >  		/*
> 
> Thanks,
> Kuba

Thanks,
-Andrea
