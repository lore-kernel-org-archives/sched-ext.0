Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013034.outbound.protection.outlook.com [40.107.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998171FC101
	for <sched-ext@lists.linux.dev>; Mon, 22 Dec 2025 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766428241; cv=fail; b=a4N+tzmwucMsrCza7EmNiqD7975KTEvBK28risdfbVHR4KwpWWiia/bcpXcRUABsCxoEhyAxoWUfQZoai9HxBFWVI/t80Pg3KdrZpBCXo2yuHlspMVb0h/T5K9eko11z6TGcbieP5YJUZVNMMcEuB0wgd0Du5ORli/gsK9amZcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766428241; c=relaxed/simple;
	bh=lpQd7K2ght9GinHtNg8maY/TtbU6ypBvLY5ZpRUsrpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RhA/0sUG2E89rDNBWf8ZLXGIKLU4b2N7Tpsi76PDh191fWhM45ArcZZQ51MPgPS4vjsETVyiEelY+G4rsP3LIGoEm1HFmnVJblEe+OjQxvEeUWzmtVF0L49LH8FVnjnaQsliQdNL+7JRVpr6YsfF/GVGesWoss+ty/zoDr38yrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jh7bPtAE; arc=fail smtp.client-ip=40.107.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jh7bPtAE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJdUxfVAFeECThiiAWF3tVvwRRa8tbOfd03eLzJKgps1lGoNfH1WRcOXcx/DK0/7488GL5kb3azUj8J6UmY/8LXuWtYXRtC8Z3DdM2na2zq7gP/WdQYmwYGdVzcYE6ZvaVUWrus7ZwTZUx9mEim0VS4gZGIcvJ3sxxd4hCC8mhEDc7xPixyH0VOarjE9MNkH/Cwpgn5XynQX2/F+grYONwJ3HlFIL1r4pmYPEctzCZFu1H29SMAg3MLW6lHNiOESe/CP9GjnPHxz2U7fO3DlU+P/neh/X7g9Ubm/B+bt+kYE1/+Z+Wb9n51PkX2rztMm8Qye4NK0pw2cm5U19vLdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzCOsqXpw/bN6sbdqb7Qxx+TRAt+ds+BBKbwbLmWxZI=;
 b=AKdOou+EZqnR4buoa+7qdh3eEXCuFoqGhPGpDVoC2Zd7xLuOtEtYuQit8na40VT2n3q17Ov08WmioP1AQ0EOMIou4zm3uxzgmyBG+hafz6PKfa/oh1Oh7tuda1u9+dySeNDkI26QAzRLQoBsZHgKCjyo+BM4dTK6rS5ig4CvFBeFMzAF2O9x3QkH5Hca/IDEn0jilSdAZdw5QR1Si1VUs7Lsz62orxV7M/ms8W0bFPAb/n6M+AVVpHAIzvR21eip0xXV2ZbpsH9CfU+XDx74v0mLH4BLO1udbdSOnz9//itbzD6rW5p8RGSvAymK+8lMfmkaweVu+tmvoqVD8n/nzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzCOsqXpw/bN6sbdqb7Qxx+TRAt+ds+BBKbwbLmWxZI=;
 b=jh7bPtAETfax2TeifNBvJ+QvsCMNxpdfv9liGz9w0VALLo8UzShITBv7i1+rP53u+BUMrPc9Yutip2vkTeBso1wVnaGCy/VE0J+MIYZjmw9mdrJa/yCcBLcLXWW3s1bPWiiuNtLrXAs2ot5mLi22OQLN/oGPvDlZpacUCxB6fJNGIlO+GidV9PVgnO8T7s9DHvqqc0GoziPB0MjzO/y2eOZ0szrS6K5ONgZh6IBA3qkQLBU6kc7BQhCZbUfCSEmNEa5Jwn5JDX7a/C/LpmdIcR0NhuH6w8aAhi5GLwazVzkYLiwSS2Hz2jaRd5yflR7AYFD5lHofffTqccgkj+Txug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 18:30:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 18:30:36 +0000
Date: Mon, 22 Dec 2025 19:30:27 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Avoid multiple irq_work_queue() calls in
 destroy_dsq()
Message-ID: <aUmOQ0PGzSGCmw9D@gpd4>
References: <20251222115318.18997-1-qiang.zhang@linux.dev>
 <20251222115318.18997-2-qiang.zhang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222115318.18997-2-qiang.zhang@linux.dev>
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff26acd-5e96-4034-d686-08de418832e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zR3Y0cj9srYnYocgu21aaPtYO0PGVeZ2Knl1MvDF/+KNTwiBYvUYiUwBkM6m?=
 =?us-ascii?Q?D8LI8IvwOyYseBFm1yuMOnr7M3fsw1YQrjnjmSMP6btkeY6bWBbgMKAuvLfE?=
 =?us-ascii?Q?JIOMSsn2Kx1hGqS3rclT3n1r3Z/OUpBipLDtqBxh3z+wH07KR54Spe+LUk8k?=
 =?us-ascii?Q?TKjpplyQqI02Avk5ZTCVzmm1WM5ZrdEddo2kounSM+XZX/3WpFVgyOtMee0/?=
 =?us-ascii?Q?zteMAGCDgtxND6A87/GVv5vWJx/Z6IrJL4j9eKhfDB11df4FWuNljg8/RUhl?=
 =?us-ascii?Q?1fFhVa94O8mXDMvRU6PgwIWT2d22Cn0HOAhuVI9/WomwX6t/pkhkT+soGxpw?=
 =?us-ascii?Q?3HoI1Ucam4HhEcpCOeFMP0KrLwozK7jUVvzeKOQ3M/PB10SlZ6hpVmturTv7?=
 =?us-ascii?Q?P4suSSpZihXpYhdQ38FbE3MsMWU2NNUP/ORrabzFjQ0dQ0fyF1s53W0GiTHo?=
 =?us-ascii?Q?Ri4O/Jzq/nwCRebF/xh8HbV/VyVvCpmj0Zl8o39Zv952I4hyoWYed9Qub7N1?=
 =?us-ascii?Q?8ODjaJkr8PtGzKQ09gU6mzxGopOu7ZZTupHcrj5HnLUe4Sdx9HYnCA+yIAX+?=
 =?us-ascii?Q?QxGGjJK5RUpeDBIdivYHUJZ+pD5OSosXZ5rb07NX3Re4W9Nw+b/huBPP012w?=
 =?us-ascii?Q?qpPvNreHY3+1udB9w9i1g7zuXr77RBFme5VKgziyLOWdlU8tMnfGExuE60gl?=
 =?us-ascii?Q?OaRZ4SELY+Bqgh/RLJQnl6bUywooyueiiKySQe71qTzfqCHfQKJlp+t3pA83?=
 =?us-ascii?Q?WLBCciCB+OGnIUB8NjfKMS/ocNa40alT79ahw/5SroCeFqZptp3M3n6bfQvC?=
 =?us-ascii?Q?s9Id0siOQ+lKJ7UNspIkgXKf+EneZ5qZY/Vo7FoGes7mdqe7+V/Va/4DOzuW?=
 =?us-ascii?Q?xqndEUeDJSHWpKvzlixmr0HKqsXywYo7rJqLgIRrMIsEGgbLzUUJC4SNdYoz?=
 =?us-ascii?Q?UhGNps/w5ZRpB+gF1hKOUMy+aPb6YwhH3ocyvdY57vRMIXXIcRoTxPknuE1N?=
 =?us-ascii?Q?bfvwhSFZEpj/hP2cm/iNRMHMZA33/Kcs6ts02J/7Nyh3oXosbgCY8Cdw+US5?=
 =?us-ascii?Q?49JoBDEq7krbuFnFyRwhsZCad13sc5mkVX2u2T0FizTqEWdUEEPiv8wwqDS2?=
 =?us-ascii?Q?EGQoRd2zMBd8b4dik4cN1suYN3+eaPsvpejLpOEfxRBCsZ7bFacMu2dtJZ4K?=
 =?us-ascii?Q?P4D6EZMbIYA+UYtD1HvxubmKWLyaWvU9CwW2bdrKoUUzEoARzZwM7sm91tH9?=
 =?us-ascii?Q?2kz6Bcr6TAgSXOZx8Uf/f/RPgGxm/9t6PzA0vY7J5HwxgbpMU+Fqf9exehG+?=
 =?us-ascii?Q?ccsNKs0LVQ2yrQ0/hp6oEAY5dCVcJek/EVo+FyMjl/Q9CmJlejisjj3kfI6p?=
 =?us-ascii?Q?cP5Q5gE/JlTuPmqQQ813fk1TwTPMHgEuLK1/nS5ISYDpKgHS7T+3jmgYy04A?=
 =?us-ascii?Q?AMUTkO+gEf544r3d9Ew10TTmBc2iRjK4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R2Avpxd0AAUnFGHxorDf0r1fpK0AfAceQ5b6mVxMK9l3Gvean8Vj9Q4cMp+5?=
 =?us-ascii?Q?nMV6zFiT6UxNp2awRo0+S9SRftFs8WVpvN5lBZo69uUCd0r/N8DKfwIO+G3w?=
 =?us-ascii?Q?qPWjd+fuK8pk3Z/K2VHCtTdFh4Em38YdDZwQ2/IsrKno7UTp5vXfgEV34l7T?=
 =?us-ascii?Q?/cCreL9bahkglAlI6JurYe/4nsRyfgeetjgMC21g7H83KO5fKAFd63getpcK?=
 =?us-ascii?Q?atJjtOpq5+7imKIKTYSeanWqFRgyQijszJ6NuNDL9jMCxofKtUqoYUwS5g4B?=
 =?us-ascii?Q?9qFZd1gkJmFSewId0Ahtnkfm+sUVlwx0/wgFS8lGHV/3HHGEmnnQph8ysFhy?=
 =?us-ascii?Q?bsjb/Du1jJK2YvU/nKjt0kMXQIW5Sqdwn7VszjZFuiQ20f8FublSQnISCbDP?=
 =?us-ascii?Q?a/PzyysrkbLZKsaa8XgBJfrdLPy+MHmztXb1slc04dZ7kfHlewfsLA0XNQz0?=
 =?us-ascii?Q?7YWow+4xSHd81FpH6r6jxibR3Uuc3oTFW5FhnBFA/Re4YUR3u+3v2bak1ugX?=
 =?us-ascii?Q?q5p9VeEbItJV/LBFP1s8SiV1doxnlyLvmAXHyNIMVZkRWlCI/GgoigMYCoRN?=
 =?us-ascii?Q?sNCYoYPSVi0W5836T/glxtw37KGnpHolG2cGQqGsO8KcC5zscp60vwXxD7gz?=
 =?us-ascii?Q?0DQT/SPb4l2yRkGYIAbmLVVb6jOFJvpZ9LfNiMTS+0/Xw+QNbckhDdL/fSYL?=
 =?us-ascii?Q?y2ohxEOZfCu5fWTj5KTdjdQyIGagkLlEI2t8TfGAlK/Gz4ttHGAz3vVEZ9Xc?=
 =?us-ascii?Q?YOSJbnKeMTVptEhVIwyf3bygh8OrKT0Cmn8ExPso898L6x4tYXFfHysbt/NM?=
 =?us-ascii?Q?Oxp1YlBANSHAbdbg/6mCwSTwURCwVOj9p9Upr0b/oLg2amrM8T94jCxKvNoo?=
 =?us-ascii?Q?f9/HV+EtAJE/BJJJk+ytww/23KHsxaP/QKc4Mc45Hl5oGyHm5WFMCOFJiljJ?=
 =?us-ascii?Q?D8/cMzYzA8ZwjFmJDyAQkMarQAiFSulUMvBeftN06K/f7MrClbHtCRHnt0xn?=
 =?us-ascii?Q?A5eHyDrWZdbp/s3v54DgCMTkDS9ih3CoANTfp3ETaU0B8RiNisunpx7bZ9ns?=
 =?us-ascii?Q?ygV9TKaTynR5FIGEskx32dUzpaM7yz54eMiULEH/Cm0xUPwrie9AzZMkkSmC?=
 =?us-ascii?Q?TDjc9VHIjdql7GCgUZsrnDLMtW9toS1cE32OTWQOToEPQTLfyFi/JzHn/2kb?=
 =?us-ascii?Q?LA6KttSbQc4AXVAjbWjBaL2nv/zCz8cFFfPkqtipm7lZbGzU8Kzntuvu8DpG?=
 =?us-ascii?Q?+EzwUDZmteiYMvQRerCAzimCG9/8jSOGpHykKy4c8DCTPxZMwM+Pux3lVLug?=
 =?us-ascii?Q?/TF9uaMxy/LQXADWJj26Ge7TAuqA+kfGx+VNpgE7ALCCsoMOGqrChEwOQ6Tb?=
 =?us-ascii?Q?QQfCQSPMWzUlhxOlt5YZab9t9DtwG9zZR5yHt+2PHEwlmRM40rrIwqcFjKKe?=
 =?us-ascii?Q?RMdpcEcD5ZS9MHR8sL8a2+FgOfl0cqSF2XSYT2FpTSKYS/6xMAy1qDdNnVH4?=
 =?us-ascii?Q?KM7V3oO8EGtKArGM486wrgVpqSn9Rth+IV44SjuDRJpX5U77dlkewNBY9cnS?=
 =?us-ascii?Q?QIYktFPgmr0db/4zMOZ8katqFr1OTzduxGmzKkE/JZz+VEsZJsBi7JC6vlII?=
 =?us-ascii?Q?te3kZpd3JqxlIVfA0+YtBdLpsw/t11GMBbFJ6eQN6X1/Ns0U+DM9kNkCQ/wV?=
 =?us-ascii?Q?qHZrgOPTDrunGLkfp+MdTItXD3mJWC0gO2WfxaYsIe4XHk1ypKE8VydXHzDq?=
 =?us-ascii?Q?rPXBviVJjg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff26acd-5e96-4034-d686-08de418832e0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 18:30:35.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVdTMxTbkNDnorXRk3+vAAjJxthN7w71jmI79C6u0EzpiqCCdA7nFisGecwuxyE9fM1z2KoSdM35LpGqgYeXTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244

On Mon, Dec 22, 2025 at 07:53:18PM +0800, Zqiang wrote:
> This commit only make irq_work_queue() to be called when the
> llist_add() returns true.

Just to be more clear, we could rephrase the commit message as follows:

llist_add() returns true only when adding to an empty list, which indicates
that no IRQ work is currently queued or running. Therefore, we only need to
call irq_work_queue() when llist_add() returns true, to avoid unnecessarily
re-queueing IRQ work that is already pending or executing.

> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

But overall, looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 8f6d8d7f895c..136b01950a62 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3439,8 +3439,8 @@ static void destroy_dsq(struct scx_sched *sch, u64 dsq_id)
>  	 * operations inside scheduler locks.
>  	 */
>  	dsq->id = SCX_DSQ_INVALID;
> -	llist_add(&dsq->free_node, &dsqs_to_free);
> -	irq_work_queue(&free_dsq_irq_work);
> +	if (llist_add(&dsq->free_node, &dsqs_to_free))
> +		irq_work_queue(&free_dsq_irq_work);
>  
>  out_unlock_dsq:
>  	raw_spin_unlock_irqrestore(&dsq->lock, flags);
> -- 
> 2.17.1
> 
