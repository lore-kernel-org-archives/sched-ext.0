Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967D82836A6
	for <sched-ext@lists.linux.dev>; Thu,  9 Oct 2025 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760047094; cv=fail; b=A/1TWus7zs+MV6RuHFXhypWkO9fOue+elPyrTP9IcQ4Tk1XOh1yoUm9eMhrSxENQew1DiDa3qUeJ917Ji8ucG7P+7iQqb/ZkVvOnpDxFMPWXDTdyft7MxrWqI5otNJzb8Y6Tz4d5AI0/5o652l8wgaBt+V96MIAByJbx4cO0JFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760047094; c=relaxed/simple;
	bh=qO8iWFT3GHxTAdn5tYHla/VzGrmF9A/pubRHT3HPWcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cmAAvYRvGEXzA7zcZgiZ06/Ijg7+Pj3IfVL/eIMoRdobebJfWLWHR9R0dxEevH8h+sDTK4SuYu4Fc+uFkdiM8V3LRgaKnIaTdiqmQYxjUtev8DWMTRqf+kdc6GmYruMhA28AtMWCR4I+phIxPOZIw0tHC02DGdDaKyKF05Bi21E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tlFN2Cha; arc=fail smtp.client-ip=40.107.208.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tlFN2Cha"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkG7bTFJ6TwOV76yLmSPpoBazGTAcLWLtLk05k/L+bWLddgMgkQzhToNatzrci9h9q+b3NBiphiyWxTNc/OPTSjKTwl/B35Uo8ZIfAWN6P2Pw5Xj/H6Vv0R4GIxXoU8eT5OGfa5/HEUX2BrnneCv5Iqvh24fAScHHlIwceyYuaBwV1eYdidm6GoC/684NPFHnhfNa6cz/WE1AA9U67PyirgPqrPBAzqMVAxuK19SeTUG492on49PMdj+juXBYAdaZNYjfore2yDd36z02LEX+nDKkdl0US1uOmnTmZPtxaluHOyYCqE6pbVV5DEohuwMBpHYa3vczAJ+7xumzj0WDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ltw/w+kpI4j59MadN7ilJRgZdEydyGq7RfnVkwHr3yU=;
 b=KYqq8mDZbh81Swc5uvxMSzuMwiQOVu3viG7nOydF9MPmDQLIFyNr7Q2hdkhC/kpiavBjGcttKRuObEZMiU39J5KVS/KCJvgRZGk0s8uxVJUp2Pyyz3L01T8MCjH2AF/vpXWOP97dQPTZOybKitZKcL/F81SY1Fukq565KhYlqqNsi1zxwhinTsgObb+nxFo33rJK33NhUORb0D+JTmXU4//eu5NeDdYXMugCIzwaYSlra1WX6bJ4HqVRQ7YnJspeyQkxmjxaOsUoXdJ15yTC/VhOHjihZBj5EU5Jh5tu3MNNsKSO5YjYFT1LpwtFcBt4JvBOh8eQmxugswgzo0b9Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ltw/w+kpI4j59MadN7ilJRgZdEydyGq7RfnVkwHr3yU=;
 b=tlFN2ChaCz268zeMUUdfhuaq+BiexLjzMtrM1CAwJdM/NMnR3Dpv8Y9fqM4Rxaq8yIYvh4FyjHNO4BaAiOzekCS1SxVl1vjsduKsZc/RVgvwWoqrsFzCfXdnVOMwZDY1EJk2xXRFqY7a8Z1gPS7CJfQpDdCxZN4L/CvB1qeV1tC3HrxEYELhLCFsgg85WAUfa+6YhTPUBlR/7Xm3egi//ovBhLjdhJOnBOsTGsV71jxoKFTB8DRqEY1avX9ff2bWwHjvG7nOfrhAEGI9i/D+KBAm6UIWJV04UvQkRMjkqIHqRKNLSVieWHdyRelISBjuqXhXjzhFbe2psaj26l6DaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 21:58:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 21:58:07 +0000
Date: Thu, 9 Oct 2025 23:57:58 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Emil Tsalapatis <etsal@meta.com>, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, sched-ext@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] sched_ext: defer queue_balance_callback() until after
 ops.dispatch
Message-ID: <aOgv5h8NGh_IrzDB@gpd4>
References: <20251009173620.1882642-1-etsal@meta.com>
 <aOgOxtHCeyRT_7jn@gpd4>
 <CABFh=a5bjhVNbaKE42OYCVoMDV_FQiaWOq8J2Fm8HBC97JVsvg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABFh=a5bjhVNbaKE42OYCVoMDV_FQiaWOq8J2Fm8HBC97JVsvg@mail.gmail.com>
X-ClientProxiedBy: MR1P264CA0065.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a13738f-aa4a-4cf6-f0ee-08de077eede3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HdX8QPSO7OKqdQjTt/O47NM3QED8yxPhUbwK1sxrpC1HDOf5cjaaDoFBvndD?=
 =?us-ascii?Q?5FXbJKDAuENHaq1IAE/sJn92wv+zvtSzTM17YWoNwTKoVIqy/FS3EX04Ofe6?=
 =?us-ascii?Q?UP4ErmRY8VI4YjxSOKGIc+foyxGSQksZTnM4ZqwC5EhNYHIK6Fw/7tmiEABP?=
 =?us-ascii?Q?N55cUx1POvUf3fiavTz7ftRkGXL41S2vGoKctOt4FdAyWn6p9f3bFKNAWpN3?=
 =?us-ascii?Q?Vb3MCekBnAWFsL7/k3MhzPTamixtDSFRIFbMBqOecPYNVNAV5JPMxzQRwBVV?=
 =?us-ascii?Q?9UlcGpXM/CJJFA4TFExRMYdns3iPqpZ27ndYXHc6IkA/52T579Q5vB5nNTVE?=
 =?us-ascii?Q?9fJ/y9aTbgSd8cNvpT+iNAccMRLhHY4KmcGH8VdPZEf2C/1IJnXHnDD6CT9B?=
 =?us-ascii?Q?7pkzdYMJKNCGZFDiIxS2Ps6zrg0fxW5E/ZbaoBQsqdt2HOmARx3A0pkF/lMe?=
 =?us-ascii?Q?/qJRmLJqPyEOav0eo/OTfulElYImANkV9JXXtXhcU4ORvXSWk9gYN480Ha/0?=
 =?us-ascii?Q?kg/VscMULpYmx2g4BzamBA6i7V3BK/HBzMBhSxMi3qDXpjB8IppmQ2Glmvrb?=
 =?us-ascii?Q?RWWHC1n56u03JT9R2j1BzZALzwURoS4XtYmI8ccLHcjqgNsW2qTHsIt1pFbl?=
 =?us-ascii?Q?q9woiRNneXMoBkDNuasmd+xHrQy0uNIO0ibCUaoamMezzYY0H40i5iF3VMxK?=
 =?us-ascii?Q?q+bkJg2CwyVb9ni+X+D+RycjRg3dViT4l0uFSttnjO9dkhEizTjkK3/sPC0d?=
 =?us-ascii?Q?hScN4eD5wAgUYt4gFYMyvk46464Osm76SMfEQqgU/X7jsiJc4MTNi4FG+SPp?=
 =?us-ascii?Q?Jw+PxcSdDLTZw7dePzWpS89pjNDQAKHTLtBwjo7/3wOZFjduqDWqodeG4lTb?=
 =?us-ascii?Q?YKJYsRKXXVcpEKBrlkC0Y5ybZmomhios9D4pq0Xq9qDJ0RrmsCiKMwSRg+10?=
 =?us-ascii?Q?7tsUm1wf57wQFsu8nIH5GA12yMkzZIvKpIMRxb66uRWhIGH64U8AHsWutFTI?=
 =?us-ascii?Q?/GruhE4OqfUt3lbvIfLX4HSY1C2bUC96TLyW6GNNTNcN7nSFs8Z7DsvDvulG?=
 =?us-ascii?Q?bd0/R3moDHICnP1mZP2uBbDkQarF5iK9EOd1NCIK3eTkpg49pMvQWid45KYi?=
 =?us-ascii?Q?9eE2HT+I4fuCdqyxnOiEMqd+BKAVz4mbEEh30r5tp+05lpBotqfLm5uN0Y90?=
 =?us-ascii?Q?PHoYD0OIuUnJ6qguapHNd/Z0L0LtVfaFmUC3Z7h5SXPjXEz17b0PlASsWAbw?=
 =?us-ascii?Q?fIOIN3NZ+CyEuGFO0Z+fJRC7HSP/pOAEJAauYup9L5IbeDP6DFBDmArE/LNH?=
 =?us-ascii?Q?WhQucokZRFKsB+RAF+xfUlS72iddvzlXph90ek2Fvtf+E1z5DdUBGU+/+Ecr?=
 =?us-ascii?Q?46JUEFQsSzDh6oZudfYWzEGg8SSh9loV24zt1fg4QkAKm+z5Jz1JqTgjTAQN?=
 =?us-ascii?Q?A/9J8RZwq5dIBQbvbSLhnRz+Hn1Y0Zv0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A0Ca+Yc1VF8NrLptJpYGZfyYtFZwzRv/kPq0ZRyefjW1cbBjrXj5s++P03R5?=
 =?us-ascii?Q?pk7wP97dNeZ4Crv6Pt96sHvA61GL7yc4zpYdTs4x1hegGfs7+p3I27H9BTHZ?=
 =?us-ascii?Q?3GEUv43o01f+/LZGASHAOCfutgaB0APxeCAEhRqBxGXtNILZx3TtsAr3MKOM?=
 =?us-ascii?Q?24fhI+cQk41AYqllQG9kXB1rUAjUsHXs4TPnnW6pXNisq62ErTstd6eYQBPA?=
 =?us-ascii?Q?V/J1jrK3lqjRkBOgzsIJ9nAZodJDwG14zfiQlfUxmbC2WxcREP7833IccoCL?=
 =?us-ascii?Q?fAnIvLRrNwj8FsjzmbyUG1lFAloLzvAb1d/piJn3Nu3RcUtijSg3Nh8l9s5N?=
 =?us-ascii?Q?fGhxjA38bTEfN0IkuKmIY0BmCTZBnzevCKXZ8fTfIfUCI4fAaBg0oP+0P95T?=
 =?us-ascii?Q?g4ABNEszWC0nUZLDF4zQrFrF4i3JKXo2YCO09qfjimhFFUxB8ABJ6yAKSXsR?=
 =?us-ascii?Q?bFWrblVT55YloGM49O/qojstWOYQMSpOyb7s1zA3SxNmCNcFVnBTQ9f6XJEW?=
 =?us-ascii?Q?qrXDdkgy4a7ny0gi+EzyO11Rfm5y0VQgs1ECM3hMTaxsj7+xsON/5v6Hfymx?=
 =?us-ascii?Q?SBI9yBY2K/dR9iPOa7lvtaAx+ziZnUKXXOGLldBWmB+ocxmXyPOr/sbjVpUd?=
 =?us-ascii?Q?3w3AVGzuSR6KhvumkuHmtouVCo0F8u3OD2vyJk1M6AVVSoDMl07j3rmyJ5qu?=
 =?us-ascii?Q?x7gFp4tAoWEcxXzy/w+cGO/hM6is4Cck2mcufIXxBH1DumifnLO8t3OM5YIV?=
 =?us-ascii?Q?YEssqeTLd/vYk0780OCnaHprFB9Q3FKwclh8uKz+Z8vWyVqOD/GpCPUMIeDy?=
 =?us-ascii?Q?Zk3T7aj+3h8oIyq3DNMIXvaYHcAr9bbKZos1LgJiYY83tmwbW/13RdOen9vJ?=
 =?us-ascii?Q?sIhMjSHgp5YOGQ8JnS2Il2Cal8MG9XTybQoXED8L+l71uFFEpwBZPGbl2Tcs?=
 =?us-ascii?Q?7lv3hMQiRONvcneAm7Q21kg80RuitIVr/xOqvz6kwlrYKZw9RUA7LaBBKfCJ?=
 =?us-ascii?Q?x3D3Qrq/absYlSGdbnXQmGG8rtfTx/iva0/uMF6is+I+I0RCqnSJHVb3vdcu?=
 =?us-ascii?Q?UJ/vsk//VlRh9zdYcW4Rat8teYLwthDWjfz6cYAdjD0uazo7grwC0E2RjqFB?=
 =?us-ascii?Q?j7CzZhynY3RftGGveWDTu9KB4PONYZ9Rd09ibheBdbT4rWJCCd+HcbnXoAfn?=
 =?us-ascii?Q?Hf//iAIblf8A2CDC0o5XvE6KMAqI9YIYoaqiYykz4IjN/5dyQPGKcERh2gYs?=
 =?us-ascii?Q?HnvMImQULl/1QzGcezqB867f9S5Yv9cSZxCDQ+eh31rxl+4vuijClpkeDP0A?=
 =?us-ascii?Q?ET6oB13EhYZ1Ofw1R/UrOtsGyiJbW6M3+c7yzfaB7JjFfD8tzEkzo9KDH3e0?=
 =?us-ascii?Q?ZSXpGBLqwvOalJ8lsr9D0mWsvfhDF+pnxlsTMkg7pNJJnRX9pHr3Y5p7IXO3?=
 =?us-ascii?Q?+ZZEsUdatth6pOt2ZNEyfrnTb3/VWmufmkkdQRviwEJUE9brZ6Dqh+bX8l5Y?=
 =?us-ascii?Q?fn9/VklKqzwZwseghrLj1bAJH+54sqJbjyj1azQiqAVQ5D8HxEwFA8GIud1S?=
 =?us-ascii?Q?WSs+YWuTnYqvnVNJOhwFaP8duBHdYsM5qg7RnQ2s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a13738f-aa4a-4cf6-f0ee-08de077eede3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 21:58:07.3561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGl/RXLT0PhVSVhDj1BnzZF1XHMq2x3pp3MFfmoypyaxs9WJYcNh5321NpEQtvf0rZP/PnSapG0NUZhPY/HZ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229

On Thu, Oct 09, 2025 at 05:53:41PM -0400, Emil Tsalapatis wrote:
...
> How about the following to avoid nesting:
> 
> if (!(rq->scx.flags & SCX_RQ_BAL_CB_PENDING))
>     return;
> 
> queue_balance_callback(rq, &rq->scx.deferred_bal_cb, deferred_bal_cb_workfn);
> rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;
> 

Looks good. With all the fixes you can add my:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
