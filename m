Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D3F19EEC2
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862271; cv=fail; b=cgjy2YN3f9J4Cf9pr8caX/v6yD0USY4Hk9bx5oWNdiqGbNpUSC3+3UOjtNbrwWMm8OJ5BiLePMhQ3rR8I+bqtibva/UyQsr6yv7gnKeZc218KC4WQhMLpwdENdN2A9fVBfnaeT2NldJDbLvCPOQ12JKAtSOmPix3EkC8z2PNl9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862271; c=relaxed/simple;
	bh=lG5KbrTYnxJYDO943B0HnAzYzNwP/ihJO7L2rBDdoXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OO983yBtixliHlLxcg5yS6suVdbERcB7Qiifrm7kYIYpfqj6m6HzZr7HRzI1gtTGCYmhStcqOn2/IyOnI2t0DVlxHa1WBXpTaACYAeKr3W8LMiO5Q7jjUzCyizd1QIeY+drhxNfGNb4hEVS2c1Yv0Yksl8S+hMlKvNMnRStCqD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XHKCGJ2n; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XHKCGJ2n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8MYF88nOAmtEyzAtGenyAoVCacoFVsI1PVEayio2P8UT5kEKLP2COAOUDTry67iIfHFb8E7jGknI+Iz8P58Ni9OP0+2BJTgnzWWH/8YXFwYRCPLVXkQIorXXRP37iijP84gc7/JCKOqUiViGqxZOK/u9sedzPMGvopxK4sf7i7gBatjeBU3cpdQxI1auoChDi2pGqcuaX5q8MVuIUtEM6dVYR86nGY7gohhZk7D6donMipROd2ihaKgTJM+xzQptManEGNOrR1fkt2sO0h9E/wqQvJM6rgY4SjpvoKnPpSOcauRWwwSo6vT8lafKfbUA9uWEOqRzNEdx/8+IWUggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3VCUE17AzZqZvd6VL4k+NVx5n99clh/K4l8HWQMRgY=;
 b=yT9UfSlk+pkeh3htI0esqHP92aR9FZ4h07LTUHzx6cd6q5d0NJpDL6eGXBHRErr2aLQV1JS9AqL5DyK28Y7FvXmikbvKG/JCcW8qdkI1yumuCA+x4WAx+UDW9ZTFBxWSedHZz91L9slqrxVPaivrmy3L9pa1l52gjq2+1M3ZjzXcP9ldhyfS8E+NkJ1KbTu9gx5/wlRKC1ClGX0LYb6JmvFebuIHtyQbUl5q5ZyMP7zlLc9sjxC11rqNVsL1cBjAlIU6x2mjQadKO5EXb/LjmA51bUwRtm5DnnOUeXEAHj29hA0/cHhYFFiVbeo7xrOkGutbn58p6COmGDeGIlenwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3VCUE17AzZqZvd6VL4k+NVx5n99clh/K4l8HWQMRgY=;
 b=XHKCGJ2n3VD9Q1vM9B3S25DW9DC1eQMb7yG4AWLMieu0YjEw1RIKjzUY9oxL9tL4Z5Terb9/ipi2tvvTDWVMGK8zmgdU1BUU08DZmRTTQrcyOUhg3J73/5P1K1PecBCSG4vPryDkGpHDmKqCnY6atMiaydO7l7/9h2GXVN3YAEUjTmpsd7h6Q39AQgWUNp8coxM8Ddm9PDNo+ehnSaQxta4L64Om4h/40PL9sc+yic892dMO4n26eCcTmvs0a3oRL8ZHIEN3k3YW1dbQQ3rN3JD00S0+trX+ENjLFBWRHPd+nldss3s7jza0QNLKXBoirEL6AN7HmUzvetpov20AUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 18:37:42 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 18:37:42 +0000
Date: Tue, 7 Oct 2025 20:37:34 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 3/4] sched_ext: Wrap kfunc args in struct to prepare for
 aux__prog
Message-ID: <aOVd7q9bNwENTchb@gpd4>
References: <20251007015147.2496026-1-tj@kernel.org>
 <20251007015147.2496026-4-tj@kernel.org>
 <aOTh_PAGkX9y2Tsy@gpd4>
 <aOVawkmvLVI95Zvb@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOVawkmvLVI95Zvb@slm.duckdns.org>
X-ClientProxiedBy: MR1P264CA0188.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::19) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7f4d3d-79d4-485f-a2d9-08de05d09988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Py2GzBNEQ0+abZSvh1NWtDSr3MgZb+A+J8MUB0Kwus8Ouoe3/HglrGD3YVDT?=
 =?us-ascii?Q?y/zDn9ZxbylgDi0mK9CdFYeWgtoCmExMvqkxFX0/Od8gGU9q/1jMyNJPqoaH?=
 =?us-ascii?Q?1Bbx2cFwiFa0/4rzBSD08K5R+SHu1Zhtgvg4+uVM+EuLm8xCK2E7KAi+HCmP?=
 =?us-ascii?Q?hm1VroSV67ZYbzD3dUsvWfxXWGdgQ/M8lGCUhKNIFqKaxlD69QAoX+EUfWWj?=
 =?us-ascii?Q?SgcRNS0zUmm1g97oCE4vvBFIOacmH6ZW4YI8RkthVDIbAr6Lo0kVxYHZg4Jv?=
 =?us-ascii?Q?7bcjWLaqeSPO0sXE5t9ht3YouB/CUMXttycGaWf9XAovAYIgJQg1xj5kDqTT?=
 =?us-ascii?Q?FUYjkfBvphNUtIIFBgHy/+G1IlhljRzyaI2fnI6jZuOaNKuNpDKtbCgi0zgl?=
 =?us-ascii?Q?KehOhi0ZQxaPGJbxbfVFAsS1C2/wl4RjzZtc0mRF7kKpsQTUZkTbReQ095wY?=
 =?us-ascii?Q?lcE9wSC8iD16nTFdfc5Lt6KsqcQQFCmj1sY8Qy4iKFkcZksJYxCz0/raz6Qx?=
 =?us-ascii?Q?39CvqR7ltbYx5CBKlK/qesnMIVQlf+s6mpp78ifGBgcURxGwTOxS3qq+Ts34?=
 =?us-ascii?Q?GvlFXzioQ8uvFjMJXlvznWMu23edsn6fyO3sawC4EwzPw2pGsumIUsaNfYvZ?=
 =?us-ascii?Q?KIGsuB2TLMCYFyPYDme4Cj3vBlZRwxLdE+jACteJX+VqQrqtssNwExyxAC+2?=
 =?us-ascii?Q?2WsoR2abVTKFYBZLUEPfQPG19BJa05na7zpv3unDZ8QJ8NvsqvtCkktW5Fld?=
 =?us-ascii?Q?CqUcBiB/eOxdqoB2dq6Wm+al+L3aTFQQFJz//O4nymbh3EvBpEBHmFhhCDsz?=
 =?us-ascii?Q?066IyTqKum/EOws1aHYhr3Vj0bd7Bpj/9UtBTq4Et/FgFJSZ7tTPPDnPqqkb?=
 =?us-ascii?Q?cD3r/3c8E0ILOI1tGabeWmvKCpAn4GxCXoHJQpNqG8DTN2B1ir6RVpV9sT9v?=
 =?us-ascii?Q?+9O+SlillL591XfEQgnji07X1h7+bVyK2h7fOYJypsmen4P3G/mOdslI8RLC?=
 =?us-ascii?Q?ckwOg8UQ5EgXPrk/PQii4ayqAbIEhFeuMXavPtx6vBwnotqVeCnGg7ZEN9hA?=
 =?us-ascii?Q?uiaNZp5XsAwl+uZSVi4sfA5ONGnTWMSbg2Uuki4zoIEP7p2QMfmBZnfUPw0y?=
 =?us-ascii?Q?/B9zJJsV/vgSnr9NGpBjUBXcTGs4o8y4dIkcKfrfEzjcUz1nGX5ZcDpx8xrh?=
 =?us-ascii?Q?Fk9E1yPN0HH4vIDyj86N5ngcC2tIp12soE5vAWcTcDw3KOp9ar2OzaF0c861?=
 =?us-ascii?Q?vUUHI2wvRwO2KDSd1/64gYCECEeW3me+utGVd0L6bubv/dBZq5emsmD76KMc?=
 =?us-ascii?Q?a3xXheDT6Z1rY+aAD0HLvr0TNXvmlZwtQbfniIBTqoiyhiq5xpTseME07XSL?=
 =?us-ascii?Q?fNGKRdm7evQuPxXRahFq/EaAiZ04c4mptSk4OATgGL4UhNQTwyKkhnwQXI5m?=
 =?us-ascii?Q?YqglKBpvO/L0hERH+Bdi4GSoS3QEq5Ss?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vz+m4kgBSM0KYl5C/KqVkjhROXBFMoh3GHe9JbPBfvAL2rMoJ5ciOeqk4PwZ?=
 =?us-ascii?Q?ZBpC5Q/5MVilReNQkP848ib2BfkMhcxKGCU+eAB/GG3lShtQz3WIj+K5ZF1h?=
 =?us-ascii?Q?B2lk11B+svJKXZthd0i2Jv73sZvRZ4VCy806IlsIDT0EPMZzWu1GSgTAI75b?=
 =?us-ascii?Q?Nj7/vEc1uaDJ6zAwcI8OjH1Yj34p20yHXXdyKLfH65ezEkgiVJSPFMfKRkg5?=
 =?us-ascii?Q?Ty65y12gZFIwU8FC0OJ7nJFDn8EvOD5LSugY4yWTSqFYnXBdwnXUoqHGnImL?=
 =?us-ascii?Q?TJ58XF91wFckq5iyZz0b1qHFHumsCZVyrlJn5E80g9CeSF8h+Fx7SpTpfuJn?=
 =?us-ascii?Q?WjYwSjVsMB+OyshUcFEhKuBbF427g2wGWelYg65G3HycebULpA++Yh4GeVK9?=
 =?us-ascii?Q?th0rViNC+H4AQ6MDZmWVhGlrIkw2YfrRtKmH8QTBJtpLrcCZ5FelOowaosxw?=
 =?us-ascii?Q?+PQtHXu1D73oTesXRInaAnEGU+Pnz8h6K3Sp/4MAEKxN5FB29rbmU6YwaRBo?=
 =?us-ascii?Q?MotQ/rucrwWGZJkiUXeQl+qovzuF1CdzOMj/0TzsqEEtmWMx100fRShraLQE?=
 =?us-ascii?Q?ZRCT+gI7X1iPHwi+59pdKgWdWDe5kbxhtZtxCJ135TUDOXdwMBtUrD3SF9D2?=
 =?us-ascii?Q?8Yn1UtPaLe3m2Ewp7ebOAafOtF1sAWIVyUgQfdkgI2l/QEj3lL/ViNRCduRf?=
 =?us-ascii?Q?4S9vnfGXd2cvjDQhuUXbbWbuVIKm3McLwj+XINb5g1d4Rjjca6kwr5pDPZ2q?=
 =?us-ascii?Q?MTqw3wx445qLH9L/Uv3bXWBqAt+Ym/JayhQsrVtOFrs9plUjAbkcGBs0HFGr?=
 =?us-ascii?Q?xgb33eAGjbO9TjfVcpGHdQV9nSM/Y4e1EFPR7NUHELIFJJmJKlKbv2RsYtLn?=
 =?us-ascii?Q?MQ3AA/3jT9J9hhFXjX4ChvrA5rPiRRy5bFMan+q4+fcgUuSQO08EAAAaiWHz?=
 =?us-ascii?Q?EhgP0cVrd/Lxm9A119ydiHCl9Z6voSKcxgYjS+Q9Y78ClsnIMDo3MrA6D9NH?=
 =?us-ascii?Q?gs/+iYIvetMQjLndTBRa2crsX+Tw/l9b+/NYAqPkfpMLGobEz2LzkPydjypj?=
 =?us-ascii?Q?zg6sltsXQcCTwvYqB0WufVQGCnLpAn4tTLhOmUDFujhuKKw28AgPO5c1SEfH?=
 =?us-ascii?Q?6P2iAiMrQB5nDYZ1o/rY+Cb5yZjcHcCRPHI6QRjqgHE6j+2lb676I2OzRyM8?=
 =?us-ascii?Q?hrnT9nwWuSCfTOG/qm3pt5vChBS4DCLS00hfJsdWejihPLsPUn/WPFD2w48i?=
 =?us-ascii?Q?OJ3BpaUCPR9xq2bNUM51RYag8gn53PoaMU3PrOb97bvhj6SVMyk+2EYGCRx4?=
 =?us-ascii?Q?N1RBNavSr9tc1OYHwKkCJa7Eq+damTkpGkLBLvxyn2e2dbldTt+ZJrc8D2/I?=
 =?us-ascii?Q?k3mZfXAgNZ7n7OESwamIJMoxoDVPVbPuxnkAOD4PSZ23RDIcZh7NoxOFHeJN?=
 =?us-ascii?Q?/yMp5cY2XMXYH9UDI8W/aJKri0Sj8NYsUduAvGe1W48fsewKI/1IFVs1SPZM?=
 =?us-ascii?Q?g/Xm+AKKGUOx6vENnKQpM9UVXzD7PiX4PLiC0iCLdRqTKT2JnFdAU/rrpJvN?=
 =?us-ascii?Q?sjXRQtSJ4hpynMikuRx354USUc398UexdA0iTXAb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7f4d3d-79d4-485f-a2d9-08de05d09988
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 18:37:42.2480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnpB9h41h0D0m0LwmWfK/5e2YkKup3nQEbtbP8xov1h6ftTqFpDW6FOW3BY+qwgP5LW0GdJ7nvBfxcXBJDxj8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242

On Tue, Oct 07, 2025 at 08:24:02AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Oct 07, 2025 at 11:48:44AM +0200, Andrea Righi wrote:
> > > +struct scx_bpf_dsq_insert_vtime_args {
> > > +	/* @p can't be packed together as KF_RCU is not transitive */
> > > +	u64			dsq_id;
> > > +	u64			slice;
> > > +	u64			vtime;
> > > +	u64			enq_flags;
> > > +};
> > 
> > With PATCH 2/4 introducing scx_bpf_task_set_slice() and
> > scx_bpf_task_set_dsq_vtime(), would it be reasonable to use those to set
> > these task properties and then completely get rid of these args in
> > scx_bpf_dsq_insert[_vtime]()?
> 
> Maybe. However, the most common usage pattern is setting vtime and slice on
> insertion, so I think it makes sense to have a shortcut interface for that.
> Even if the overhead difference is negligible, it's nice to have a dedicated
> interface for the most common use case.

Yes, after talking about this during office hours, I agree that it's useful
to be able to set both vtime and slice when inserting a task. While the
overhead is likely negligible, it could still impact hot paths, so:

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
