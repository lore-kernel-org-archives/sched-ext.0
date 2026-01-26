Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013010.outbound.protection.outlook.com [40.93.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE372D979F
	for <sched-ext@lists.linux.dev>; Mon, 26 Jan 2026 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769462825; cv=fail; b=GWl8LPLAMynELqZs+l57uQwRrK7HyVEZLmEAgY4ld0THOAhnp2d7cY9jlop34xaqfwamjlUMDK259/kbqpl4+QFn7VcLRAcnlo5PFBMNsDwzrTMaYWfzu5UgR+mTY2MIYW9d15jpg5K5v9Fq8mk8avt2Lzf1CypU6X6Y57CRdGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769462825; c=relaxed/simple;
	bh=lJIeqBzv7HMKobDFK0o6r0HzSAdAWn6vC5ORGvPFHes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rup4F7cXdGusgkiCm/7pnB8Kuzp92py+32B/RA6BAEKBC3v4ue/2x7YOzIWw84AdnQOL/NWXcd5bbbVmlFaelcIWz7hT6G1faYnIgkm8IBozJSkb3l+6DmKDopamlkaowDcomjn+Xx+BM9IGfgecxM7JMxdu35/qq9mHH9yxSa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=scFunV2s reason="signature verification failed"; arc=fail smtp.client-ip=40.93.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="scFunV2s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTVb/BU5FEdXsBvgxNytsS+JkwI2TH1LFPDSw5slzUc97+1X5s6Nw+wrnsrjDRNFbJY1hcJYDtkWg46p6mAFaw2BO/FyFPCpFBg18uso0vGOexKnFsG5OmvrYlZNDCKjmV0BDrUEqiTOAzvkqzLhLfVOUcltDxAHW8Zyg/qIEVYGUWrw3gsqKvTjli6hOQxeMmRdLQcIt7GxdKd8eXtPeAUUSei8qTB8kWMqx88qaCE3PA47HX/CpoUaLmur4W+/9rhVNSfriRurOW31CMkwrapb/oP2/C7A6O0gQaLHT3sVnF58waJHltyfQLjwVsRsdpfLTsKJuqoFLpnGgamtqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bS6nFjsbmInYiQgCbJmLlRi5dgeQNodPOidotMlJnhQ=;
 b=EnPrEgnM9ihUutOFaJJQmn6paxHSRWnv6Wm62cd3GfGSIzvPFs0VGvPMCk1EZNzxoDR6+luiePG/pPNLwIAlQlQzF71lxLstzI/TWzJ9ssqcLI7m3pkwiVJOsap/WPeXDlg3qzpoWcZlUjHVQk7f2vBreQEZW26HntJLff1Fo0rpqy+afZsc0cjK7iPi365PgYahGj1XmTnfz7Qd0E2jppDuMcPknpd/K11PfRbtOOS1fUX9/FD6PbzUp1SJehcKKSYm0bKjiflZgLaEnpCSQfZKAcjYEGG0pdSYiKfMz/e6rb0RB8BRyNGp6ZbkOSZyiqxVzw9mrgl6BkDyQrwysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bS6nFjsbmInYiQgCbJmLlRi5dgeQNodPOidotMlJnhQ=;
 b=scFunV2spYjJVtY2RjyPjLyrJ+sTAAkSpHfUS9VZMwyALUE3n6QfZ/l9383TAPPdgkjhdKW2eiGFGxi2va+u53QfdmTqe2Dqgjx7uLG0pmhQUi5LGJjB1kQhWJqjg7V4pmKa5i2/PatZXZTCbDVcF9xtvBEdsIw4uYezUbvzkeiJn7KQZYGFvg4julQv4FPR0OW4/uWyvEgrW1kJzTkycf91YGEXi8pM8BFIxYImmw2QZECcRQxYSkXk9qnAqewFNZsAveO/jXDJJRdHexFEPfZ9l4eYXMo+LRI7wr05brOJmMmB2qe98VJSe/i1NW5kEpwGlPG/o2/3+DXKywUfJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 21:27:00 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 21:27:00 +0000
Date: Mon, 26 Jan 2026 22:26:51 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/deadline: Reset dl_server execution state on
 stop
Message-ID: <aXfcGynN92kyw5Co@gpd4>
References: <20260123161645.2181752-1-arighi@nvidia.com>
 <f99f63b4a777ff990832a27fa6d171aaf1206a75.camel@redhat.com>
 <aXeWnzI3ymUSm3Cu@gpd4>
 <cc33e6e3-3ffe-4ebc-a2e3-7dd7afe13538@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc33e6e3-3ffe-4ebc-a2e3-7dd7afe13538@redhat.com>
X-ClientProxiedBy: MI2P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 461f0d63-10e4-4afe-f45c-08de5d21a458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?JRxeM3o35rQluWuw3WcQTZkMOQwSWYwXWG1Pd92LZNlDGh3RQOueGlAK5s?=
 =?iso-8859-1?Q?D0f81lYqhit+BIoOVTYYq1PbYIoIkx1jJsqH4Rrfba1Mesw9YqHM/dfVOB?=
 =?iso-8859-1?Q?gwQBITAWBur5Abw85rEO0mizmr/fAMym1avHN2AEuPc2AoP/xnBiMREgDr?=
 =?iso-8859-1?Q?gknOvlIVF+8Eu8bw8Nt+EFDCFKVUiVMfLfimsEy7V/C/wNI/JhzrNUTp09?=
 =?iso-8859-1?Q?58mgHwq+xStykoBzDp7JVhETXSJo4qe/b5/dYefa8BY8fG2VNt82U/M2Rw?=
 =?iso-8859-1?Q?YWLKAz777/P6wv34KRQ9qSOT4sJfPdoJw39lIuKCyoZlZWf4OBZvXjfmmV?=
 =?iso-8859-1?Q?L0XyNxCtKGGV2ir+YaZ5Ksmdib9QKRW1jrkRl5f78oe6PQ8OkbDBWs2rIQ?=
 =?iso-8859-1?Q?xEN5DdBlUc0um0I+/5x0705uCBOPtBo0COBkbckxCUi5+RQLVNLgpgwjFU?=
 =?iso-8859-1?Q?FyEXNa1cfkK8sNV3haRa/Ky+LOCAIw56PgVkJYoNOAlsfjgRNIIFzlyxyY?=
 =?iso-8859-1?Q?9Bmu98eF8Bohx4Yk59QFvlCnKQIksAPBbxbYeglxHJ24GgeOa5gdWr/8PS?=
 =?iso-8859-1?Q?bOBxJJ7OYtaS0iU5YjY4AdLzSRWMyeZRPFWzg1nXDL8FspZ5N6lAhk/0p4?=
 =?iso-8859-1?Q?YmbNLX8BziBQCMik7y8hoT/HFJALBZfe1B27GGPPvDFkrEHKs8Q7oCjcqN?=
 =?iso-8859-1?Q?hMRidQqy2sfnJwOo0nJ48aS9LxbSFjPG2W5hqC17eZ5Ie/nm0SioCal3Ac?=
 =?iso-8859-1?Q?Z5Ds36daqh61i3TkVAn4nACL/wmBxWqYw7pItwFLh26KA8F+MblXSk9Kh/?=
 =?iso-8859-1?Q?arl6ygHqTDF5amjCb/m/Fwbmk2qvonV1QkyPIQrm1H+heI85tuMAWCq5EK?=
 =?iso-8859-1?Q?8+ng/P3eSUNMgOLuhU31zWmu/KUbyDUdKNk0u8tXx42xkQtcfH4jKxD5UK?=
 =?iso-8859-1?Q?MJU1ZWA1K8JsZwM2rgeY44CUszHbpNpnOykOaXZGj0nOBL30ydtof3/p2I?=
 =?iso-8859-1?Q?xsq09XZDeKZTzBoNy+NZz+m68NVqtuYOulAcxnILaJmzotN4ADv03jZ5g6?=
 =?iso-8859-1?Q?ByipRJtcjddReyY879DxAO2wZQLdgtkIFwgc9vfPzLmLTozmf8yj9oRTKc?=
 =?iso-8859-1?Q?g0R6+B8VZ8V5BN8HyA1EDd59jm6GlqVzQsSm7lbpcikJBD6nVEsH1lzvT+?=
 =?iso-8859-1?Q?Ys4+kjqRqVtaoKnMvyvUDwVSaelewV6uPwCfSbVbic2qx3NOIiVjJSx/Qb?=
 =?iso-8859-1?Q?8KM9h3htSDufuAne+PHrUHy8VT8JUaAUdPc+xOGKGRBMeuABdR9WnBeu6C?=
 =?iso-8859-1?Q?1s9YwBtMvJCh8OFp6qPj1Mt+uRjffVpK43xJuxKVxsz0Izjm2q7v+bb2/H?=
 =?iso-8859-1?Q?WfUhgwkdWlodZcTeOpMQ0iXlzfeHKOgH9kzpEZXN8x/Oh1SXWhm64SX4zg?=
 =?iso-8859-1?Q?GPPjoxRZ1tcot6cn+9743iZrl98k56hz0LL8mgbkEqAikG/zWXVEETuC2Q?=
 =?iso-8859-1?Q?RTCpJuVHMZZ1uoVr8+BjwdqUKQZqk3JJ7hTXcvS34mOG0QOjdSv2YJAIMU?=
 =?iso-8859-1?Q?IHLb5JBUR4D4YmuC351iocSH8r6G1yXUnNr4gqJHWRZ6zXcA2/NBLsBNIz?=
 =?iso-8859-1?Q?vFBWX5FphA8ec=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?ZHwtVUb/3s09Z79K5GyuP8NkI4W9sS6pmIpT0uohnaI570HfO8/BYHUV2p?=
 =?iso-8859-1?Q?kJVv7m40WM69SnhL4qEiyHb8q+kP3RDIhBTv2+Kru1sdUQfRcuGGHJSC20?=
 =?iso-8859-1?Q?h+zIkI5kWedm34QH9JSh93+X/OjcNaEnueReeDkTqFwFh/rexIiLRd77Ip?=
 =?iso-8859-1?Q?oWOB5hs72UOZ46OmJ73+iKOBYw+az2lFw7KO6g6iWS4BSE0QOx2hsLf2u5?=
 =?iso-8859-1?Q?t8kq2bgadKL20pa+cGRAnIfXdAkTJ0pIrvoelT8AM7wb9Y6VNOf7TKLI3H?=
 =?iso-8859-1?Q?cUly4/hTXdI3pV4B9w6OS9l6z6p0/PQgMU9bg/a5qmBgoHsbaQzoww31x4?=
 =?iso-8859-1?Q?y2mN/Iq8VT9LdAVz0SRaVzbSTSmk/epM6hnN0meH6BMuymwKhZLNFD2VZY?=
 =?iso-8859-1?Q?CRS4gCVOwIshPoVnh8As3SCIO5MsWR7ljQMZpovXrrKKYYjE1Zgdw7J38X?=
 =?iso-8859-1?Q?bunEZm3p3kVe6dxeFWo8GGRZ8KMyf1kU57n3JSgy2FasGI4S+1dgMNNPMB?=
 =?iso-8859-1?Q?Ul4+lhWUFWdJcCXx8xPPxpX6VUlrI0HcAXPCOqn6MmhRDKmm9n7z/9/cGK?=
 =?iso-8859-1?Q?bmxm6Fi6ZoNoqNEcO6GUQeNYxB2FbAZpaNP3SSua9IeTdDbfB1V7+9ZKak?=
 =?iso-8859-1?Q?VcBID/WNpWxLnUsdAlVNPwbloLBVW527EOm5bfxs+WsBKxRuq4LQtZuK1V?=
 =?iso-8859-1?Q?fgyZr3z+QoZuesjlIbU7IyGExHlakRfpkQQbe/noa/3QlsXcmp0tN7SrW3?=
 =?iso-8859-1?Q?Qc9jD5ku1B9omIdNY0TVSozyde8IM1Rd1nsOv2bREC1nx3WREShBfAbDK2?=
 =?iso-8859-1?Q?1XQucTkr7UJyqCuTJjDMoTmjClw8lsvfsmbXRNdJ2UKC4AABiNIF37zNrW?=
 =?iso-8859-1?Q?h9AQ3qKVcLcAHq8tMLfkNz8Z6y2R8ZsQYH2tIHMihtSg+v7NP2LxSYrH78?=
 =?iso-8859-1?Q?RLowHxGh+KKFpDx8DTbgkMK/pwN62jv/6mnlfkL3nJJ3FeaO8GJQ67N6/W?=
 =?iso-8859-1?Q?Uq4/pB1L/BghFXbP8M03RvpQJfjkGS7EztcwhEdqbdAB5v+Q/V7r4an2Tq?=
 =?iso-8859-1?Q?rFJM+JN68+rJSVSS15rJ5/2nHGVwB6TdgttlPt1hxarjH98WSfxOtngdXw?=
 =?iso-8859-1?Q?yUExxmPr7AV2X+vL9ZfULeoKnaJ4+jq/m6dZzDujZOlQWRnj57yFFkcwbu?=
 =?iso-8859-1?Q?xlYBWh+FZOJN/t+VxIoL0BcZz4gLYCH5R0Dt5/tK4Wl1ymg+vbSw10bMW6?=
 =?iso-8859-1?Q?oES1i9QgQCfnEAv5Db5fVKpw6yfDicFjS0cKHh5srI7mtKXpj28wFa9vzv?=
 =?iso-8859-1?Q?KP63JdzX2BNIuNgkJwFIWGwyUbFNuYvrPHxzDkI0SKNfmjBfFsSRdxZLLC?=
 =?iso-8859-1?Q?gd8DyyJXCZjMcwZI8lE026byuW/tbC+Y6Tc6Mdwd2eH9hR9kpdhJ8d0Zd7?=
 =?iso-8859-1?Q?jnAQMc1z33oAgnlyL3zRBWGzGkR7ebH1NZ0x6xL4lwREpXce6XWVO8Pcif?=
 =?iso-8859-1?Q?xGQ8siMgCBdkNw+QgtHX/siRNVKbqwpYBuUr9TA1OgKtYJJM95cXtAQUAO?=
 =?iso-8859-1?Q?agklRqoy1KiqTrSTb7VScjr/tUF3xDo9gDpM3N6XIJXFQvfsrMuWkw11S3?=
 =?iso-8859-1?Q?JrcvKhR1oK7ahVeEKZ9thnp1B5R44USNXef1YavTiTSfropjMUECf0c/ks?=
 =?iso-8859-1?Q?/fppMkzVaI9kVleZHemP7MQtJ0MtdEavoZoJDnjSl065tdvCaDFg22AFAV?=
 =?iso-8859-1?Q?zHxIiejQ8Higc9q1+Vi7/ttJu9Q5xlEu9HFoWFr3RCo/gd3KsUKfW/tUmS?=
 =?iso-8859-1?Q?e/xeuqSz/Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461f0d63-10e4-4afe-f45c-08de5d21a458
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 21:27:00.7404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHNuUeffLnkQw1v+KSvBOqCsXyLwI/1M7EgMQMTksQTDfo4lt/rZcYZkrgMmFxsNmlIMGgKROCdXUw+C7NaofQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111

On Mon, Jan 26, 2026 at 04:56:52PM +0000, Gabriele Monaco wrote:
> 2026-01-26T16:30:45Z Andrea Righi <arighi@nvidia.com>:
> 
> > Hi Gabriele,
> >
> > On Mon, Jan 26, 2026 at 03:20:12PM +0100, Gabriele Monaco wrote:
> 
> >> In the sequence you described above, I wonder why the enqueue is never
> >> replenishing. As far as I understand the runtime should remain <= 0 only as long
> >> as the enqueue occurs before the deadline, after that it should simply replenish
> >> a new period (pushing deadline and restoring runtime).
> >>
> >> What am I missing here?
> >
> > Replenishment is not triggered directly by enqueueing, but by the
> > deferral/replenishment timer. In this case the timer is never armed: stale
> > dl_defer_running makes the enqueue path believe the server is already in
> > the running phase, which suppresses deferral arming, causing
> > start_dl_timer() to be skipped.
> >
> 
> Hi Andrea,
> 
> thanks for the clarification, but I think I observed the enqueue/dl_server_start replenishing a new period when running.
> 
> Something like:
> dl_server_start()
>   enqueue_dl_entity(ENQUEUE_WAKEUP)
>     update_dl_entity()
>       replenish_dl_new_period()
> 
> should happen if the deadline is in the past, unless I'm missing some condition down the road.
> 
> Still if it starts before the deadline, the server is going to get throttled as you observed, and perhaps since in your tests the CPU isn't idle, we don't stop the server after that dequeue and then we never replenish after the deadline (because we never start and as you mentioned, the timer is not armed).
> 
> Can this be what you're observing?

Yes, I think it matches what I'm observing.

In my case the server is (re)started before the deadline, so it immediately
runs with exhausted runtime, gets throttled, and is dequeued. Since the CPU
isn't idle, we don't hit a path that would stop the server cleanly and
reset its execution state.

At that point, because dl_defer_running is still set, the restart path
assumes the server is already in the running phase and skips arming the
deferral/replenishment timer. Therefore, once the deadline passes there is
no remaining trigger to replenish a new period and the server gets stuck in
a throttled-but-running state.

Thanks,
-Andrea
