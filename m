Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16E830100D;
	Wed, 24 Jun 2026 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302265; cv=fail; b=JRLwvInPvc9CqZumaKTeHrZdqrpaqftFLZlzIE4B5aqjlQrcaVRTXzoOVN/F26Q/XidH9oTIcV56XXMB92xRKsxAsjGQLuD9L4EU5z3L32rHfBOJDt+1lQjVPULSQESTMKKXzD9D3ROF9Zk1fh8p/Ii7SQZKsS0SR6A0Uhy1n/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302265; c=relaxed/simple;
	bh=2sawJVuUDRiznvovuWP3jy5uu8jYPyPuhMHcDhESozs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ccZrDh2U7EUfC0MFtFm96CI5zCfq5SOogOGiKBKujuj6XPjqhDhmmUMFhbprTCP8zku9YMCOp5/NUQLuU8sDk1KSf3qL1yrD/W59KFKCAhazhuiapCzeCDTKjFEDFnOnw4JLBn1Wf6V5L7x6Bnq0P5uiwMgvnpId9NctIU0Vh4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LGKF2xmb; arc=fail smtp.client-ip=40.93.198.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LGKF2xmb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkQdoEQp3MIa2RIgsR9CbLEF0aaIrDOc1G7bKQrxLdeZF1UIf2/I2coMsGQGOPwvKa9R0fQctAe1TybfiIuO40cd2LKKFvCzVEo3CArvCWhkYqdSYfDvKLwbzz2THVTvYU7E5oJLGVMQJmQCS7LhUY6nQVGEBt4DC/nk/rXXXia4tIR9K5968uLqKnOvXtLy0Tjg1l8ORbG8gWI5Sx1Jyy0RWrdLuYCwgLUSTu3hMF30hxN9OlU8P2Mb+7zPqNZckC3BmHoQ9DwBjgymYnmgQDxyL7A91jWc0TR6cQ0uC447N8s2ruz/QURHwkBP6Tr+XMnW7CDyeincNWhvkTWEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRDB+0DfUVH43nwme3v1w73BAAmYhKt+Cfq6V7dgZAk=;
 b=e+nhDfI/r0yPBxz5l7bF+1iplCs1+ANqPOddFmtLtYjgTPboTMbdwbdeAHnzdIXbPVHFW8Ll9Um03mvuIFmPrcM6qjJBpgvalhoIEdARUzUSt3W7PejjYoiv80CnQeNqgWlLVte8/pZEcu4iW0dQs3JnSnJ94WjNHra8lK8XpQmmH8NlqQ1kil/6nrRyc+QhZLjaY6HHD5jEcdJ5Kn5+5YFRIUM+hZYdIg62aMzs/sPhGQa5x16cJbetScVW5KF0wR6sLrE0onPML9a/Y98eLbeD7/82AWffB6hGFmAXv+ysigUH5Cs63+vIZWk12DkEqzb2Auj62iUQPyjU4VuzSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRDB+0DfUVH43nwme3v1w73BAAmYhKt+Cfq6V7dgZAk=;
 b=LGKF2xmbP3mFDLoI6Qa42W60808lN9Bkqdg7LCRd6oBs5MAh9fM5WrW/CU3+Zz4sEGWX4/sBLB+xQdNmz0xffdGOmp+3ROH4xc2G+mYVIMr+hDm/jqDX3lawVf2S5ngXwCwaksjK4IOGyMGUP0lNIMycSenluK94YaExw/bFG+794UZQaumsT5h7QoSsbd0x++ehIOSd88IPsHsrVF1h5fdp2wn5K/2ODddbA+AUlaea5iINKl7nJpydJyJTfNrEBr2zsiJqMEXagqRv+geOEF6CuJaCAkIua9yxndRMBfDBgEqesCKhuO7EiTEZ6yPH9ird/iVgLQvJ5PyBAVLnfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 11:57:39 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 11:57:39 +0000
Date: Wed, 24 Jun 2026 13:57:27 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Zicheng Qu <quzicheng@huawei.com>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	peterz@infradead.org, brho@google.com, bsegall@google.com,
	changwoo@igalia.com, dietmar.eggemann@arm.com, haoluo@google.com,
	joshdon@google.com, juri.lelli@redhat.co, kprateek.nayak@amd.com,
	mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
	tj@kernel.org, vincent.guittot@linaro.org, void@manifault.com,
	vschneid@redhat.com, tanghui20@huawei.com, zhangqiao22@huawei.com,
	quzicheng315@gmail.com
Subject: Re: [PATCH v4 0/2] sched/fair: Fix fair load state when switching to
 fair
Message-ID: <ajvGJ4Uui745fbBA@gpd4>
References: <20260530050609.0D0FB1F00893@smtp.kernel.org>
 <20260624091648.271891-1-quzicheng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624091648.271891-1-quzicheng@huawei.com>
X-ClientProxiedBy: MI0P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::10) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cbc3d9c-5166-45e2-13c9-08ded1e7ca0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lyJI6T779zCCyDCb6/HMNgC9PGoqPHf3aHZGxyEXeqv3jAITAutsRtpuMMErmPkOsQhaPU7tC7tvm/3UJ36DOha4FUw2x0ao6WWzyCKUFEhKzh2CXE3z+D/sDtzvRZUaO8Ti0F5VvhNPuVoG0aggmpaQI+1AicgCxOXit1RlaZLVOZHRq/2YET+H8kc8/JDP2PD1maIOSbaZ2ct5wrX0Hh3HMyZ3zhWxrNZKTS3mYZk/eEJlqUfMqeigOA5ej3ei5l+0JxZHxLmba72K6w4aDwMREdjemVC6THWgfNFIt5xoVRtPGnJxNh7Z3BK1TpAdlpX8oD8TzVILk8fesDGBeVfmMGcwP5/QlBnbDYVbKrk0/2r2P5o+o7wprGQIKwwNxbgDdO49sGUi/b7FkEfgbkUO8IkhHdP0fXaE4hEj0x3ovLEB0/K5ypZa8WeuPHdAC/OtQOsBiPpibHo2pLKUE58FDaRJvmXQv3YtpgI1UDRuZ3UN/3DrZmdYvWeh/xN8cd8mszMwH3npY+0hu+ZIYgDoWJFyKCHXX6f8Bgf1f2DEuXeYVfo4BmwImsaaVTB1OpOn8yau6nPbz2s8wBI/2WXbps7LNvh3Moc9u/jQEzlaNQ41p/2LKd49SNOUOzDOntWFWPgKa7c8Nu24aVbJkVqLuqL+VUSOdhAN1gysc4o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0LOsXcceuibDUdxaPCDmvXfCf8f1w0qZ7QlmhOLM9G3jNOO1DHJg1lz4n93U?=
 =?us-ascii?Q?Q3IMUdt9qg0qF9u6I8WlmNw3D6dIMvbpGx6as9dEmN0huD/To12Apf+xQ4mh?=
 =?us-ascii?Q?DkVVtk0hNVfuGikjyFvoiW7+8osJzVg/eTDJHHJ/JBLqX61QCzLxYfcrteJ2?=
 =?us-ascii?Q?iRX7v35g0LjX64oSQE1HM2WhyMD5Oya4y7LlTzKGSVt8fhwc3H3+C0d+g4+s?=
 =?us-ascii?Q?mtmQSqrPSai90lCEtZNpeYjP3i7JwLR+5sHPM9aS3Dpmzt3g1mmmgOGLAfzg?=
 =?us-ascii?Q?N6xT0HNxPOlWMWKP5GNSvX0LrWduXHnJqmX73i/yxNevX6ckLC0HFlFDzc3I?=
 =?us-ascii?Q?6yDDSi5rEmrT6dXkBKdfuxdgp6krrrjCCKooDs+Bl3xBECsiiwi9rcLAnN+P?=
 =?us-ascii?Q?8b12az1kYRp/dWHARDt72LEyXXTJUjzG/6qEHkv/NFuBwATFr/GAbg9flVmt?=
 =?us-ascii?Q?jtFJt/hhnZeYhAysloZaA7lmBGFvAo3fuQQ3tWmVWFvVL/YjFYkfpGdNM+jy?=
 =?us-ascii?Q?vZFW0a/8AXwPRqVxXN9sFwjaiCA+WCUs0txBnxtPeet0kW7/K+3mYd5vAVc1?=
 =?us-ascii?Q?b1xmIcWg8Y2/u5wnv4N4DnS9eBlNz1qGIhw4QTRXhVMkd/m/Nnbl6HcC+lD0?=
 =?us-ascii?Q?mwRov4d5MPXeANYU1VWaJeVpkallzLhRR7cPuQnbkfpa4Lglz4qqM2Hu56WZ?=
 =?us-ascii?Q?LAx8Nrye0pNDVlgO7N8V6EPTFoeT5cmqlrZ4SFUFmh2ilVvxUp/noPhZ2SO7?=
 =?us-ascii?Q?xwHJBAcDaxAIQWFC2/rFaMWf5qL10hOz5z54YrXKkgVj896imLgA6MNWolYT?=
 =?us-ascii?Q?z61HZmzmOrV6/qfuUTQnr99hAtfHTgb0V7FifWZ+tJPDz8/dkeCGbLY7P/VW?=
 =?us-ascii?Q?0unceXxjIo92kuwhcm3Tp0QXMA9HGY0GEt7ACOl3fS3HFCHH6Zmlqlqbw+U9?=
 =?us-ascii?Q?Em6/ffjKZcN3RRP4VNQVvo22Yu3yexZOWdiNlj/3JpDgRNobhD67wnXtFD7X?=
 =?us-ascii?Q?81HuqArrhjDFwKcOd6LaLmYMnKu0YLtcxANE/sS6S2XRHGCId7NNagusYWpP?=
 =?us-ascii?Q?w1XsbgeF1/qJQVTqsAfjP8fX/gkxwQWrcqKeKr8phLisiIOYow58rMLdNS9M?=
 =?us-ascii?Q?AqW4z7oocuPEF2wgWxrGDGQGoH9Tt7f+9+aeIlwz+n8g+rnM64EIbFgI5OXY?=
 =?us-ascii?Q?02pKNycX4plxZWWJAYSnHTz+Lrqq0odXy7nD3Tyrdtmi/Jferv5va5iwi0F6?=
 =?us-ascii?Q?Ro0fD6wb3t2RkdwSJnsMmxh6SuH7rQOHkqwsI8Z+/9guwO3BRfSD5JwE2rMd?=
 =?us-ascii?Q?V6MO/tLruzpBTG6KF2Kffxam5ENoRIHlMLmIwhy8H6u4X39FlXeN3mBX3bYT?=
 =?us-ascii?Q?Kt33gifa2ojTHu8Q0SQY+0Pqxe5bUZMW1QLlCtrkmaO5cJslth4ATdwpVeFb?=
 =?us-ascii?Q?/jdzuJ6yrnng+by79rnEStg8BVAtpMCj3W0SDreujq38Aga9shWwF9KWnheN?=
 =?us-ascii?Q?1QC2kVaA9+f9Wv8lyweUz6pthPRG8Psn8NuQi4/jwCCRAdyqaMSLp3gAjBYK?=
 =?us-ascii?Q?7/OGuUlSVeVnLQMDm93rqvseClcnxSaNGtJhYICKZ26A8KkjhvFDiiaDJ9sD?=
 =?us-ascii?Q?Oi2wv4HJkh4aufJIVblbAPhbXxiCnCwhqsPTojXnY/8c+z5NFKPeOLdkt690?=
 =?us-ascii?Q?Gbvz+RcznjUnQ+pgVPH8ztRVq+Xe+G0aS44n+Lmef3PRNMxB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbc3d9c-5166-45e2-13c9-08ded1e7ca0e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 11:57:39.2945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjgiXgoVHw67p4ZN8a8LUpYPgpEL+czDkCMs8aBa1GpuKDF0XFshzssyU63MO+vOVOI+cuW0Avasuwbur/86dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698

Hi Zicheng,

On Wed, Jun 24, 2026 at 09:16:46AM +0000, Zicheng Qu wrote:
> Tasks outside fair may leave fair's sched_entity load state stale when
> they switch back to fair. Patch 1 rebuilds p->se.load from fair's
> switching_to hook, as in v3. Patch 2 keeps se->avg.load_avg in sync
> with the rebuilt load weight before the entity is attached back to fair.

Looks good to me.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Changes in v4:
> - Add Tejun's Acked-by to patch 1.
> - Split the PELT load_avg synchronization into patch 2.
> 
> Changes in v3:
> - Move the rebuild into fair's switching_to hook, as suggested by Peter.
>   This lets fair prepare its own state before enqueue and avoids adding a
>   sched_ext/fair-specific fixup to the generic sched_change_end() path.
> 
> Changes in v2:
> - Move the fix from scx_root_disable() to the class switch path so it also
>   covers partial-mode SCHED_EXT to SCHED_NORMAL transitions through
>   sched_setscheduler(). Andrea identified this missing case in the v1
>   discussion.
> 
> Zicheng Qu (2):
>   sched/fair: Rebuild load weight when switching to fair
>   sched/fair: Keep load_avg in sync after reweighting
> 
>  kernel/sched/fair.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> -- 
> 2.53.0
