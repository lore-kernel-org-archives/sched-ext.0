Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD117372EE2
	for <sched-ext@lists.linux.dev>; Sat, 26 Sep 2026 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790452750; cv=fail; b=gdPLhNKp8RUrUv246B+fzpgYmxuA2RuesLQXc8N3B92S5FFo+9okW7na+DOaZYQMzugJfX2diMpCfmMFpFddxx67n5/78tIttZaOmIy+K01QrOJWeFLJWZ63cC1N6Plx5X2uOGoWwNzEBFlO0+8dDDT557vaEw/Gk/3UPpHGL2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790452750; c=relaxed/simple;
	bh=xv3khOlPkYMbKBe8Is53uLjVMLP3ALsrrNTyuQF3JkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C6yTrx78LNr4C8DRClxgpy7LzHPMtla368GNDe7jwxeISN+6Cw8xEIIZoFkQg6iyY9oVIsFielTzwL8cr3DYuw0U1tLIfW23uBgxfAvzp3K2MF3/W4FWqooriADNgzyn5w135oOhBUTgCqB5xvWtn2Tt1DD21gLmdt30de4Pn78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bi46Lez/; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bi46Lez/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfdr0rUkxDU071U/eYw2W/tYSR2MKzkQREokBnVVfyP4CVq9qJjDmoY/R9uRGHZ5YHQtOGharpx7FHEefP58GAGOnWwfrW2jKDpz6fpwVFKvcEZ/pn9Btf3LakIScNj/B9zQ26aj+nL0SIFnanQ60iiMaG3N/1EUB3OOQViNUEQcm6xw+a73OvkkUfEa/tM8kyl8Iss/UcUnDlykD3a+axKxlDLoAklR1cZDvhyVDyeRqiS4y+1f6s05hWU4e37cn541IuD3zkc9dgQVh7R2Cl4dV98P/QoEWGK9P6mbsWQ2i8U1Y+oiptzWwyjQ1sKhzpFz0hREoKNnOM7CiWNhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1J9txA6AZ5Wb3iRc28yePvE76f/AdjUgxVLrRtUDk4=;
 b=ScfDcDhG0poA2TVPGyP6RLbYiNwAzAk0tDNuLUnvsIA18U76lsYswHfOJRalaNhwOr6j9OPUec10MQL134k8WkcyCU2XOdhF6myzb2Ysgq+U/Tp3WwZhToQwe2Yx8rYpJYPniAjHeZtVNOpo1tG8Bgj4Teo45cKXyGGkKvXKwFqDW1cyxHB0f4PfUf/tZrUJa1s0HzJ/YBbbzVD7m+WMhUDjpeiweQHIcss+T/Q+veI9R36DY0BXLqFHpr7JjJXmntIJZrsmMWd3JoRmdqGayyfD6Cef2PMkax8I+MDSlDDqCifMM0MJb4vs7lzZWl5x2iYm7Hz59FUyiP7em8KkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1J9txA6AZ5Wb3iRc28yePvE76f/AdjUgxVLrRtUDk4=;
 b=Bi46Lez/odj2/MmcQeGBjXMIZCBzwby6aivwjLdJOOg29IluJAb+N31vj+67Pkla5HEM91Qu3NLRFIX9UqUfeefMzsMow+2FKUP95RiACv5wo4+KMGhUKe+o24zM6YqR+kT0udvKABaixm/zTNLAs2RwIYJW6no07h7WS89GInpla6cGakVF1rjLxWwE9iBrFbx8xF4eEUwyzyseO1fm7nYg7OZX9ttItYN3+TKNigYPPyCrMd0lD/SikAzeYXBF2i+kQxvdXw+T98wvwZTFvQzbCd4/dIgDM+3t4Wz5LjRRx95pPM0duAWbVoAakVXbdtDgew4NvbuA/znSEn01+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 19:58:46 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 19:58:46 +0000
Date: Sat, 26 Sep 2026 21:58:37 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4] sched_ext: cid: Represent clusters
 explicitly
Message-ID: <argj7cXsK8WL6X0D@gpd4>
References: <20260926152306.3190774-1-arighi@nvidia.com>
 <23db458c1526966f521d41322ab47056@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23db458c1526966f521d41322ab47056@kernel.org>
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: e947a6c1-f64e-4c8b-847c-08df1c0892c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|22082099003|4143699003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	itZPqVa9DzEXAJYJmV+d6L8jP7Xmk0qSJbfjVC9uorzLmXjOpJgoliGiSOCT/k3JtSUnpWxZ1KXL3DADEsgRG2XvvPUDc1faogCcbIqr64B997VPpfGsiW9Zz4viWlxUcdWLuP3elg5BgFMB3jSnh/qFwa4dKOyU8Ak1H5+oIGEzz68qr5vIPad5MqDTbn0WadlDJ8LOPlkgKD8X/FOCLXjSsDDpvtzPR4VuvXohPtkq6JwlhGlLUcjCncw9FewwG22S6ZbzC8ohEk5e8urTxxesWJrLx59IpZCDXbCdVBolCkKHd1IyXaLtfjofhdKhDIkZK9GGQFhxRMkaE1cRMu5pj1cAjXZXmArdT/nm50WsLw9SVQ63YKi2v5m7Qdds0HMVWIpU6hWe27ubi3AV8ThvVzdsLp73MBzDUCl7DFhYJDxgh57Jd4Hz9YyMMjhDZ3zYHD/Jmdao/R1ntlUFzlAdAX3h5LVbRaqvbKpLlfjUg2nUw7H6dQav/ljyq71MO4MywQ99+4G5Lwog5AcIC+i+U6ZJtihmMw1ypNW5pTkA8N3XKOB+ADGisZIluFqn+ucZh5g2M712fGko7/+cj2TKtz25ZCnlLgg724xbFjadNqYrvtqH+uFnWT0IzlHTFlc92szzaKY7ei/493M4UBZox3ziIiJFeKb72yxaRzQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(22082099003)(4143699003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g3F9GPxsM6ORi9anIRv50JK5w0pSR1w5ZKOD+TwADYcPPLE11lAmBLtqrT5r?=
 =?us-ascii?Q?Z9YbGyDC2p7YBFSgohxa93TPBNOZRv8eEsY3Oa3F+G5OtZrC31K+RuiqK5yx?=
 =?us-ascii?Q?Cvk2YGg2SuGH3cC8KZzoOOZTryluBqCVEToenNjrPu2mS/M/cNLk8U4bjW/7?=
 =?us-ascii?Q?m30Zks3Wyrwop/JOVL37pBPHVPhumpX6/LdA5Mnfw4jFhHcX0UaxDB+NZJV9?=
 =?us-ascii?Q?ziTtxZZ0EJy9NtFVvEiUSMaWEIgeWR4t9wAC1/rXLA0gciQNxpAaMQaZGilw?=
 =?us-ascii?Q?lrHErNSET6cMnQVqgy/r5pxTbYzeOF3pouzAJzbS7k5wzOMjUeUMNJp3zR/W?=
 =?us-ascii?Q?dlj2tVVBQ2e/M0sYUQvPWtEd3gjq4sI36AlslvnTv90MjFzdnNed8XHe+dIr?=
 =?us-ascii?Q?VgB07IS9wGRSyoosQ22zlwGm7SvTMfPBeGqmpY1rqwYWBe7NgFSBW8JClYkY?=
 =?us-ascii?Q?RrOEClSfUfJ+92bDrG6VUA830BNLOnHvnoqOuYPafpOnVxBY5so6pRcf3IgI?=
 =?us-ascii?Q?4KnqcPj1dSDTCWpkm6NsgBurDENHuu51yRWTyGeR8k3Wz4ltbeR0a4Ui9s3k?=
 =?us-ascii?Q?UZBwUpGFKK/GkEOgOt1cZlfOEmMQMCXr4bGnOiuUBKgAyQU/j7xZIzgcD7Gc?=
 =?us-ascii?Q?F4IllSMjFs9qUMIAs4Eazl2Vqija8Ki1GSIbQ4ThdrHwbBpHV9cwEy1q4JBZ?=
 =?us-ascii?Q?fuCuowf5L/0IJIX8MP02Zgc61M9zLzvkPciczdWHMKgag2Q5bLByczYIVjEI?=
 =?us-ascii?Q?6i2Ykl4cCav0ofjztC4/Wo3bY5zhQ0cVPjwwQvW9EerFbvAOeYFwlBzQrCNv?=
 =?us-ascii?Q?BLTjl2QOraKFtdD3Vgl2jONgDl+ik58FUue247EU6WuwkJUUzDF3+5mVhv/5?=
 =?us-ascii?Q?jmVx8dwHtuJmtDRZLKgqvc9ix7OclzbpOeV/ipa5QvcZUp3Ce5njXC608PtM?=
 =?us-ascii?Q?lMYNxo5l5/a4MTUrsdaLDmkih4S314Dwh1Q3HrFZrWnRX+Rnb2G2S3uCLMqp?=
 =?us-ascii?Q?T+WhcEZP+Ojnk9YqIIsArALlmVuMCSwYxo4IjmVgPTGW/W/BDNvajl1ybAZD?=
 =?us-ascii?Q?P4IAq6EXrJOrHTP+pcyZuxaCDqQWT0p9q5vFzeh3W73DMLO4XhAgvDaLV0p4?=
 =?us-ascii?Q?57gw/QRP6wh7ZUfmZdLmSrjWSUUno4+Rqcq3lUxCS60KFabdCCEU6C/C98tj?=
 =?us-ascii?Q?MObJR0mHy3feYbq7eA3h/FaQyOHROrkPEQ5EUAnMJrd7ZmI1/7rrlY0Mq8Vg?=
 =?us-ascii?Q?ag27jqH3yigt36hfRy+Ph8AHXplnMcEyq1n5GXQJeVyUvI8ncwEYMx6WOUbo?=
 =?us-ascii?Q?OGQjG7feoBI0gO5L2jqrgeM/F2LR1uqmws/9DirA9ho86/djUU6G7wc15vkH?=
 =?us-ascii?Q?JvIihcUD9McHtsnWkTeOh6/eqGFFiEl0ARIN9yio4XxtdYWQ5xIDM1mCOQci?=
 =?us-ascii?Q?oGTTAseQ2Ei4URAW9cTymVGtsB/I5/f6ATL5zP4pkOT/f1lIKFgccIlg3b75?=
 =?us-ascii?Q?VILl3ctnMEV/olcw5beePOgDFVSz1etH2BFf2MPgNd3Ev3VqFmDndvpOqTr2?=
 =?us-ascii?Q?nmdcYHJJfwqT9r2X1jkZ4U9YgIaFQ7Hy1xpu/ueJv/pNg9cy+HtSs76drkef?=
 =?us-ascii?Q?QFjPv9UMRFKipnbmdu+/Uf7MgUCJ09ogWmQY8yFU2wa0iUPXe8ki+2CZBjgj?=
 =?us-ascii?Q?Iji++2czw+WLUNoGHPBzO1dwc2jW3rOd2LG22gnso0RoaRmmE0PIPPk8auEZ?=
 =?us-ascii?Q?2WvMdHb9tg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e947a6c1-f64e-4c8b-847c-08df1c0892c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 19:58:45.9315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFAGIRR+e+/Qt+rRxOxWUdjrcTn4S8WOBDTPBYRxQnyd/qLrdkfo45/ihSKBkdn54ZzCl2W5PlKdzZIX8tj4MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132

Hi Tejun,

On Sat, Sep 26, 2026 at 09:23:15AM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Sat, Sep 26, 2026 at 05:23:06PM +0200, Andrea Righi wrote:
> >  - set @cluster_cid to the LLC's own CID when no cluster level exists,
> >  - set @cluster_idx to -1 when no cluster level exists,
> 
> The other levels are inclusive: a level that doesn't exist for a cpu is
> represented by the level below it, the way a core on a non-SMT machine is
> just the cpu. Can we do the same here? A core without a cluster level is
> its own cluster, cluster_cid = core_cid with a dense cluster_idx. Then
> every cluster is a contiguous cid range, cluster_idx indexes per-cluster
> arrays without a -1 special case, and cluster_cid can't alias between a
> real cluster and the fallback cpus in the same LLC.

Makes sense, I'll change the fallback so each such core is its own cluster with
cluster_cid = core_cid and a dense cluster_idx.

> 
> > +	s32 cluster_cid;
> > +	s32 cluster_idx;
> 
> Growing struct scx_cid_topo breaks existing binaries: scx_bpf_cid_topo()
> copies out the kernel's sizeof into a buffer the program sized from its
> own vmlinux.h. I'm changing the kfunc to take the buffer size and copy the
> smaller of the two, filling the rest with -1, and routing that through
> for-7.3-fixes so that it lands before any growth. Can you base the next
> version on top of it and append the new fields at the end of the struct?

Yes, I'll send a new version on top of your fix (already reviewed) and keep the
new fields at the end.

There's also a comment from Sashiko about dropping __uninit, but it looks like a
false positive to me, the current verifier checks the out buffer for read access
even with that suffix, so restoring it would not change whether an uninitialized
stack buffer is accepted.

Thanks,
-Andrea
