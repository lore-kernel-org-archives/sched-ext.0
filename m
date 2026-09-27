Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5B74A21
	for <sched-ext@lists.linux.dev>; Sun, 27 Sep 2026 06:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790489584; cv=fail; b=hFJRVjcRiKJpzHfuhQ7huimQx37pCbOB1Ufocg0bm+MZSASPPlBh3r4wIcXJafHoI6NIj5N7NQuE0E5mSkE58NAAm6DrKLDcL5Dn8IIHv7an/vz5Vqnhd3fm0P49cTnZLHYBC7w12XIJ5bzji2RyzFsPyPoCmrpOJJfj1g6XTqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790489584; c=relaxed/simple;
	bh=CJ6++pe8NWp9fexmqrl56gNUwRYWWfFi2tHnIDCivpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L7OMnzSdd0xM5wx0zz6oleE/pn1xwVPMBrvSSSubBOEa9pJGm4xNmP0WEHAJa6fHspqqmeO795bh5teL6Q/JdxRWddGbkfJTSl875WGhAZbe2zwg6pMGq0IQV3oLVhcnPAWzOX3vYiUYYSN1LAQaMSnaEJWoJaG/8z92VP9VU6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C5/vciS9; arc=fail smtp.client-ip=40.93.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C5/vciS9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDZAWA41Jkeum/EHjtm9vppV6z+45Ki00bgfJuWZLoCf9YDane+sPDDKyJGlyRwPM0HO3l2pIhJKmXKN4j0dDkUFXzk8blnD/0WMH3/4Us5BOXB9oSr6LPyZu4XgwYohIz0htD7XxTK5BVz36DK1Q5ibESn8eHS52/poJd/IWiJM+wF82NYaUPbPHnpBZmWSBuyM+HB+Wfslo6feNeXlV1evGOwu8VMKeXA9ogoDvo9KnfUHn9qaThGWp6i2UeAePmcz11YaHtHuzSRuW+GqPw+2I9zLITAJHsPew0dQy75kkELNkgxwIvXUpPG9i9bOKbZnwD0fCXjJAF3NOXDnLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlVOqv8YLhKGR+G+WvY5lIehoq4JEUcPLSBK0pcL6g4=;
 b=pp23Olo5OGFegOWx81suhcnzrkVe9Vtyj4P6xKT5xDaHHCYCv290X7gHwyfn0Rx86JsWmhucbOQm7aI6nsUOTLY/32GKG5eRyzh8d0dh1YFGMy48JPvTI/yZXlsi2qv1FMf2vVHUovH0hF5NdcBUO64himyBYbT2xZ2l1JnN5AULDDUqjfoIvoEZb8tDBNbnOs9Qt0/zNbY3SEhSX9+YWzyuApi3YreAjbTqbwQlc4WqsyjtWXkTFfkpqVRN6KT6hfuyIiJ8lP6EX1FdcnmOqpXCygWgz8o2IKT64+tUwUkkOl81Ww3L/plGfgyNQ6tuZ/t3kKy1nDciznX6c04pOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlVOqv8YLhKGR+G+WvY5lIehoq4JEUcPLSBK0pcL6g4=;
 b=C5/vciS9Hy+NOBABlgq6a7TlfoLyBvFndenjzOivcX9ETjfsAJjm1kwtnnzwxQc+h3vXgjvqNIYjnJVHbBOOAVg+Q6QudRTrVfvLCtC3FwMqoXyCw9Ya3T7TJW43aGQwd1Rly+j+Em1/Cj3CUZaTXYcibOdFKBEn0rgIG/cnjWALrv6iLFz8O3WNw+/d4B+mAw6CIRuD08CyYSjw3Q9VlgJY5JGaiFlY/jq3BnrMt0H/WiX2NTwoxID/g/IJK4HbbpJjAlFUyBd5DYsDUk2+UBqwW1AEtPZ58lptPzXUnyVYkFu7k16ZVS9sqJ6OBAHvmBTE/5f+j14VWr67f9dbfw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sun, 27 Sep
 2026 06:12:59 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0451.014; Sun, 27 Sep 2026
 06:12:58 +0000
Date: Sun, 27 Sep 2026 08:12:47 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.4] sched_ext: cid: Represent clusters
 explicitly
Message-ID: <ariz3weoajVYTU2o@gpd4>
References: <20260926212017.3351797-1-arighi@nvidia.com>
 <134cbadbf6412d22d6bf34686f7cb422@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <134cbadbf6412d22d6bf34686f7cb422@kernel.org>
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 6775dea6-38bd-4bef-8a57-08df1c5e6036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|3023799007|6133799003|10067099003|11063799006|5023799004|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RuG4mu2rpuYMUaIX/+X2+OpeMl/IJXGsBOglWjTq9j85SipPPNGUH0m/UewdnYxJ+3bEekoAS9hEfaDqTsKVCKQcX2sdhW6cwlrgO6TyzSRE3q5/q+MXKiqKNC1quldeS0EON5mxW1KT05rYTmlRNKfQ+3NzkbO6nxRzMrZxokjzz2ZSp9jg9HgUmciTrhgloPkmgfddC+UYbkTh22i0Mtk0spMG10OL+X7s058Cg03wY6osX3C2JcHdVlSflW9ShC8zgrj5x8wrrpiJBpSDtYBR8AfeuDTk/TJXjQk3mQSIPwpJp4fhSNUbewa1/NvEV+0Z+xAkjL5vTxp6TIZJRG/YIY5pPfDfMwkwnXOMt8A/rcUa06GjMNmLHQwrkW4PrlddYcHv91IJENDr3rceNTFrb0fBLWNlygksjGJjoF7prv4WBRW+4zcxv8DrZk7i75r+mcseRr+F6WNZfxPpmCBZcmeGQic860YyMhwiSu0jrAKVMMnmvMTvlKzlL9hRFO47bOZPgVDMZdPLKznOd+xZ31gSNueMpMQYALavZmSL5DqMANIMCl33bGtku5wjA3MBa+5UYKXYUv1KhZs/5LRap7XUwnQNcMqa0qTbtFjrs8fu2By4XNndCe23rgqluN7eug51iCi7bVyRanX03TBSE6ChMehsMN1HHZxelNE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(3023799007)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ksHwHf13ez8uiQyaQLQTJiZMPt9rhjCMKo7+8JiAeO+ycYUjrNckqAMQOKtf?=
 =?us-ascii?Q?YxDRDeKod3fwR5FEs13Ui3qO9/HNX9j8DZ+q6QTJPLxyW2LzG5gdqF0m085i?=
 =?us-ascii?Q?tz0x/9de0lRNsT5+0aScFcgZmvYuNZaeUDg5/h4o4ol57WnJsaRg+b6hII/L?=
 =?us-ascii?Q?kJwvcoSNgbDj7ZINLxNyD4gKwbbP7q47fdZuQAiJG4KGme21dryX4uoBkplb?=
 =?us-ascii?Q?WFBvDVuE2RmoZ8NiCXGkb41oTeut53zBzB86SOty5bnVO0P25k5SUPd3BxFl?=
 =?us-ascii?Q?OmkMX8kCJ9CIdGFN80e+EJaqq1n0dZxvQ/99VhcdyQlt2peFrZwEfjt65GCf?=
 =?us-ascii?Q?0SELRvmIiwGY3iNOnmooAU0yWdz+KjuXkpmcQ/HHU77LlVcuOM18sWPmBJBr?=
 =?us-ascii?Q?4Vz5XbM+6xb2+yyWkl9nQs7TjnIyNeefOP1RIUA2reE5ZGKiG+kI9UALijIm?=
 =?us-ascii?Q?6JraWMUrTbyPKogksKdLPKIIaE4XX8QWrDv26Qrdp2h85RRyx3Zyj+br+V56?=
 =?us-ascii?Q?TfmWYPt/CtTLrz4x5Z+wUiiGWlMMOjR3PFj0+6MNqcELREuu6J6bsaURL3kX?=
 =?us-ascii?Q?7vnHA7sKhQA4u7fqZqaIV30rC/29bHruFG3P5EM5laakYgwsr4iH+MxasrU0?=
 =?us-ascii?Q?Y3UEzc03V2lYsYVSw9FXlkCa2QWixvME25GGMVXJlqjJ1pzYudZI3yrpVJsk?=
 =?us-ascii?Q?VScuo8enhFZuTgzEpRXSx9wwNHM+MLolkJ2N/fMmkUZ9zhm2hto1I6eVWone?=
 =?us-ascii?Q?+S1OpYFFBJsw3iPhL8j9scGN4DGvhf4j9c4XyMq9OQDd8R72krSa14BzDK6V?=
 =?us-ascii?Q?JPbfsRvcTf6MPUUTpkPnWqKCfDfzCB3uXhOPuz/Mme+bFZhjA8lzHSUiOOyW?=
 =?us-ascii?Q?Y6Gfm/MHZIXea/WD4koTQfP88bPoSxL1Pf4U1UJl8nx/pErWJgAgE4pL3nw1?=
 =?us-ascii?Q?RGUeaX/oH25fwRmYsiCbNVIBnetgXT384p3Ugnkqm3hFLFFDXH/I9Qf6OLuN?=
 =?us-ascii?Q?ik/ovaXciknPtyhmAbUfaPbmVQ42TR/l4uOz19RmPKj9KlGVvOsVO1NvIhYc?=
 =?us-ascii?Q?WXGExqv4xTZ299q4ToAkz2nckU0g2CktHr/4Q3CJIfZeak1nR8L0XEy24O4r?=
 =?us-ascii?Q?QV6TuwzWIHM+F5T54YH79DgXqAyUMh8dtt9bbE8t6GNvhSNJ+wURFzGIpVBR?=
 =?us-ascii?Q?oRxNpIzcls7yDt0TxvjSBwrkrH7qc9Odl9lRVNnsDgJMpV6qWadgwYxGIhUl?=
 =?us-ascii?Q?B62GQYo5YfVcsTuZAA6IBYj+fiW0ZR8fzHZlcgzcRE/PgNejmth64UnYtPaX?=
 =?us-ascii?Q?Ez3bbnDtbIeJ4lbXAqVRNiSjaceD+wa4hhtC2/wn4OiyA3uBIlt5y31pma0X?=
 =?us-ascii?Q?UOwWofzR+IsqY4x/poYl5M40m3z/0E/Yd0Y3cYwEBZveGWZc5AHSgjgtVChI?=
 =?us-ascii?Q?Z2npDKeHyxGaRSeVWQbS/8OMRk9eBQqGNlntffsCh++a8QQmuK1nvrTTUc1O?=
 =?us-ascii?Q?5Ju42gfLa7LmrEffAlI9zIQAQU6H1s2LjSudc2UTcrBQbvpzwoZBOSSxvPKD?=
 =?us-ascii?Q?RSchpjrwgN4PZI60mud5YYGsqhzM7xYml8gbzmRqH4+i5wYVAUZokn3HWGxp?=
 =?us-ascii?Q?iv1oD6fyW2wnoKij13STq/0oxKmi4kVYr1rCa8NBoRZGrR/9ubzj26SbSKDj?=
 =?us-ascii?Q?SWzLGuNMefOXGqPWfPm+uv6I52Z50+z6cJUE3D6HrMfyjDVxaB/1lNhLAfYZ?=
 =?us-ascii?Q?MqcZ8DG0LQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6775dea6-38bd-4bef-8a57-08df1c5e6036
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 06:12:58.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UinAvwWf9qxxfS9j3XlutQp1eYze6yHibvxlxHeBVpf9fWbqXhWBm2ApG5FHiG0aNADQVwf4W/nHAWXQQEZ8Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306

Hi Tejun,

On Sat, Sep 26, 2026 at 01:27:37PM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> The following is a Claude-generated review.
> 
> On Sat, Sep 26, 2026 at 11:20:17PM +0200, Andrea Righi wrote:
> > +	if (cpumask_subset(cluster, topology_sibling_cpumask(cpu)))
> > +		return NULL;
> > +	if (cpumask_subset(llc_cpus, cluster))
> > +		return NULL;
> 
> The second drop inverts the hardware on a part whose cores all share one
> L2, such as a single E-core module or a DSU whose L2 is the LLC: each core
> becomes its own cluster and a scheduler looking for L2 sharers through
> cluster_cid finds none. The sched domain doesn't drop the cluster there
> either, it drops MC and keeps CLS. Can we make the level inclusive instead
> and skip the conditions altogether?
> 
> 	cpumask_or(cluster_scratch, topology_cluster_cpumask(xcpu),
> 		   topology_sibling_cpumask(xcpu));
> 	cpumask_and(cluster_scratch, cluster_scratch, llc_scratch);

Agreed. I'll use the inclusive cluster mask you suggested, so an LLC-wide L2
remains one cluster.

> 
> Private-L2 cores yield the core, modules yield the module and an LLC-wide
> L2 yields one cluster per LLC, with the walk order unchanged. That also
> drops the helper with its NULL and empty checks, which no arch can
> produce, and the lines past 94 columns.
> 
> > +			s32 cluster_cid = next_cid, cluster_idx = next_cluster_idx;
> 
> cluster_scratch is always empty when an LLC starts, so the refill block
> assigns both before any use. Plain declarations, and the per-LLC
> cpumask_clear() is redundant for the same reason.

Right. I'll remove the redundant clear an changed both variables to plain
declarations.

> 
> A few smaller things:
> 
> - The comments in cid.c and types.h describe SD_CLUSTER and when the sched
>   domain drops the level. This layer's contract is enough: the
>   cache-sharing level between the core and the LLC, and a core without one
>   is its own cluster. The sched domain also doesn't exist with
>   CONFIG_SCHED_CLUSTER=n while the L2 masks do.
> - scx_bpf_cid_override()'s kerneldoc still says core/LLC/node is cleared.
> - The test paragraph can be one sentence, and the Based on note under the
>   separator is moot now that the fix is in for-7.4. Maybe "sched_ext: Add
>   the cluster level to the cid topology" for the subject; nothing in the
>   tree uses a cid: prefix.

Ack to all of the above, I'll send a v3.

Thanks,
-Andrea
