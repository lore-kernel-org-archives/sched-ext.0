Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213B825EFBF
	for <sched-ext@lists.linux.dev>; Wed, 20 Aug 2025 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713981; cv=fail; b=PO/wQUlsfsCuHyZg4aq8shdXYBX+nKzZOT5xRiaAkslaziroCYte12fYnD0D94Rf9+PDGI1msCdT/emvn4+STfooBo4s8/WI4yBpcHlYfruLTcPzdcor3r1q2bQbZ9vqAvcb4RzYkxSzvWauRitau703JYzIuGJCCDvHpOvKk14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713981; c=relaxed/simple;
	bh=G4jvI0+GLlamLGIkmHs/XCWMvi5BzWZRiuCBYWzgIUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ISghXV4DIIha4RsDwHOV4ktAweyTaXeR8VvUOKzqvAswZ53eIA4NluxclwxsUpJeFL97SHEsSBfTARuETtcR/lbHNtjPOeoYPRJl1B2q5hNIXkFK9YOSycpwTSjoyYsJKsuvkso8NDSR78PmKNV8Or4Ft0BHZW77r/CeiaiXn3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E+icdukr; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E+icdukr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9j/25gYhckiSBCeidf7NKJGG0O3crZONvo9cBXT6XqRgTD+fgWmXLfkw1DzpPDHOP61DEPqicEkBeMYHHO+nYZCA3rLIhV/iZ65YZNcoqi5TIO0iJ5jSeafK1tnVZ446tkffZ/rN58fZj1KEXNgIwV87pIp2kpwcEQvDWI3Bg5T7nlsErPRWCw9D46XT94ogN6hRkoYNKEftUkGcwU+20oHFDx8s7Ajo06vtFITiVAPum3HfGjrLrqJA4PbKgfC42U3Qp6xPy2LyDwovT1UYla9LNEMHnQrhWw6B1biL3taLg6yKJqoT/ahkxAPbDYK977VRabatkyyq3eJnDgLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLvTxB7waLijfefvXe1Aw1rQ6IQz6KwNr0LR3UUN+24=;
 b=aqrPqBoATtnCKKwX4vW6QZpIEHg/6/86kuIM4j5YlRjipvMoDO7CxaK7VxWdSyyz/qG+P/q/wh4SODptZkml0oLLTKEo/zgz5DH0tyKXugXsxBl+PWiZa7NAIkw3iNQXAjPf4qHDNkfPQtq2zkmANsjOFVK85G//mdKOlfOMwhjdLmTeITJqNqP/23O1Nnc1V6fsAGcwed1h7AU3YVsHE8JUYmZVdxSORYyqg92FzFikgUUabV4ZW4EzzdHhtxxew+YrBIygCIclBsyC0fqK44VkREpeIerUTDm+Fy4PPssEmLi5vD7OCA5v7Y0ml/AKGSBGIkdhIa0tVjCDsAJDNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLvTxB7waLijfefvXe1Aw1rQ6IQz6KwNr0LR3UUN+24=;
 b=E+icdukr+A8+0Ku+mmmUiTdTCrZF1KCLIK3SeaSKbGzd8u9PLqyHKAdAiFDjwHXpe+w3VybE3i+ube5HVO7ML5LDq4bdGndTHlf8vbxEbPvelhzbsQRcq1x8uIiT1Vvg0RrhNBB7TbA4mEGBlOztwt7Ermrj2+b1umYyXYFHwIAbRfpOqqElfB1JduZQNbmHQsAbrWWdXGqdMuIcs585L2Q8U7ioEJAabXqem2h6WE7yxLLLgryjKCDanztoXQQBvDYOlCLQYObZn+o7Hn8EoDN1+P0cl+TI6Sor2YValp5h2kNFk4cJAJNCix/w/uUFva/IYlUu35h+M+YHRC9lNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CYYPR12MB9014.namprd12.prod.outlook.com (2603:10b6:930:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 18:19:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 18:19:35 +0000
Date: Wed, 20 Aug 2025 20:19:28 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH -rebased 07/15] sched_ext: Add a DL server for sched_ext
 tasks
Message-ID: <aKYRsCAJqAzVGuZX@gpd4>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
 <20250809184800.129831-8-joelagnelf@nvidia.com>
 <20250819075714.GE3245006@noisy.programming.kicks-ass.net>
 <b832305f-5642-4d9b-8694-a60ab7c4adc5@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b832305f-5642-4d9b-8694-a60ab7c4adc5@nvidia.com>
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CYYPR12MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a4d8133-35ff-4d03-36d9-08dde0161e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?po5KgQG2nmXBIwGjPXQlLvJYlxm+LcayCPB8ykoixEepI2gjUc1/FlTMilJq?=
 =?us-ascii?Q?h7ecg9iSyJgLISK2xeoCfB3swiez/poo6AoBDxgEoM32nEL+Q8iS8xhgZEck?=
 =?us-ascii?Q?tX40mn1IatfHvSXA2KC2/WRKRKYuftIKpS3Jdu5kr0iK0n5cLeTQ9EEDIFie?=
 =?us-ascii?Q?Y1P6cq3rp+isuIV/CjISdhJWViRTRP05ae0108QtRrDKmjdfau4Nysz27Zum?=
 =?us-ascii?Q?2XREokC0BULa93f6SWUwU6DE4TKyQ9jnSP4W4YFrgrCr7tZxEe6SBs1gOMcQ?=
 =?us-ascii?Q?++jM9M5VPwX7aUgwuO4M7XY5iPUiXfcQcbnM1yQnc1dWl6okED1n18/us41L?=
 =?us-ascii?Q?7q8buVb+gAcySjolHkivMBIR4mNhaYE1SgtRNNnSerT/wwmncqR+8doxkba+?=
 =?us-ascii?Q?zEKKLgjtFdPdGT08bN2Bnpuv2l7pXC9Qal0QCu6sKr+dvCNqYqESG12WI0wu?=
 =?us-ascii?Q?YF2IM+SxByes+TLb4K6sFINUZw/Xo0fyg1QjacG3KviLJvFjLnj9bljIkN20?=
 =?us-ascii?Q?SZaw9zAUNPZOmuF21XbXxEPHwd/nU4bcrvlhSBik9zwIxEqIX99actSUTsti?=
 =?us-ascii?Q?0IWFwMTvQzjK26pNOSsvnA0+lzkadUnQce3Qzi5fzJ8/o7kv/sHydwXxDMvv?=
 =?us-ascii?Q?77BKBAl+vS5Ugk3UrxU74HNTFtNp4NXD3sXWJo4IfVv/eYmLvmHKARwyQR16?=
 =?us-ascii?Q?KQ7sdP+Lzng3Vz+0PG63UlDxBx6j1RaEJNoa67HB1smk5/g+rBbd0QMDQW3a?=
 =?us-ascii?Q?Vtt6YMtyoBxMY6ppLCFQMBHGxNNXkicWO9zHyAiJJv5AN8H79att6oLDfwdD?=
 =?us-ascii?Q?7ZhjERRURgB5G2dNfd+oJ1EJWq5yIE1gXK+vZqJ+/N5ScHQIo43gRzROySYm?=
 =?us-ascii?Q?espm02lbSMpjWnauY5Zd5QuNACz30Al8GhUXSRqS2V5HMz3jjBQZaJZN3f8Z?=
 =?us-ascii?Q?53Rhie/2/9H0oIa/8KC8kdHyQY5XeY4ySW8QE9A2v5o6Pv6LE5nOqGrWU8Uk?=
 =?us-ascii?Q?Y8YUL5Isk/grUcOkWRTKw3mKom5JdAgu5HyS4AyJhDN290qVCECFbdreyE5U?=
 =?us-ascii?Q?tZB9nZCfvAUisqhXFUcGrcAcTsd+dgpbSYJevh9fStKTAmvZCnEZqKA+0Vsc?=
 =?us-ascii?Q?Y5xCklmZ57zexjNj3qxCcuxbAF8LGleOQiMsRYQ7opATDYG+TbTwqmWEewY/?=
 =?us-ascii?Q?YxhmD9JxQFNtd91rF+qYksDOU0VQtq8jy4rZc8f8GE5ijxNWBlDgawcdFNwD?=
 =?us-ascii?Q?Jog9blL83siTCyHwLv2NHXIVmduLejuEs5yoF23xPIdYk3prIjzKql6ZU6U/?=
 =?us-ascii?Q?WZxi7ptqVyNSAo8f8Tb7ozEPhTOsvaEurqRa2Uo6kag99O1a8y6J8B+GnaRV?=
 =?us-ascii?Q?rCQyvTm8rXFF+V201qAcYz/5cefgPrt4ab5+1iMtlC7sb8dZBlLNSzFB7Vse?=
 =?us-ascii?Q?at1ia0cASlw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ddzdknsY/RSE5CO6qVTEHmmKnQ4PRSzpB+u3dmtNYEAKeJxq3hoYvjGHxNKA?=
 =?us-ascii?Q?EUqpHPmStSBLlU8D8rT8W7TQWGQXPhIqw+bmex8gXeI8dkS9z8VUUAP3tlQr?=
 =?us-ascii?Q?aChbYwI9Yl84PzJ5nnAEMFVV97sS8xPpwd2UQDHZgfg4EpesnFUY47Cadyy9?=
 =?us-ascii?Q?jsRW18JwGXdkL0WRedK8Fj7DgptVeAQXZ09CEC/U8wspEE8LByOF8i4jXGPk?=
 =?us-ascii?Q?YyEP1hROkN6R4Ygo5QrsDuDwKMRBHE2D8B0BBu0lHqGqjAiHkU7hlwqk5Nod?=
 =?us-ascii?Q?nWAuc+0QHXZzyAdIZqNVgvm6jsuncBxVWW/vUJu12IHcky5qVGx6tn3DBU9w?=
 =?us-ascii?Q?SS2vh3lcurx2zOyEVKrOKqaySyOkLzYmZGqQyRdG8NiAF6zPkt4GbDFmasFu?=
 =?us-ascii?Q?+dCEtzzjzxoPfMrqbWweNVYJNSkI087rdm7GzlZG92G2EJbyirjsJJYNyIu1?=
 =?us-ascii?Q?KRLnblnazvGDfh5QOiiCJ7f4tBIZazvhP9vfJYZ1ib5Rv8OGlJw4YyxVp8le?=
 =?us-ascii?Q?YpUG+Va+yXGRsyY8IuBUf0mq4X6p7DpcD6nVhkBuBfzzeVH0w4Nwu4ba+qTF?=
 =?us-ascii?Q?hEQHGOg2+LGNjuIfx0jAWgRSN+he+ZVFyXiToRyu2AE00oPGzuhbKM4GVYro?=
 =?us-ascii?Q?Y7X+ujZv7Fh0swqIvv+UNW3Cq5QKpABrX7oi+bCSSWkAIVY7F1PAfvpkcW73?=
 =?us-ascii?Q?JC9uVnaZfoctD5vUcxmpEz+af9tLyv/4RlV0THQ9f9gGLnlQ+FIHzLJhQ2qm?=
 =?us-ascii?Q?j+x5r4gJ7PemSNI90R3mDzIJWb01+/lmNHVT2DC+Gzb3+NiJw+o6AjjEuPV4?=
 =?us-ascii?Q?tVbjRHJvUYZ59T9SvtZW9tXgGXAfn9+zbW9Vxdg3bEg29wIezQukTFokd0DN?=
 =?us-ascii?Q?yZuRDFNlG6ApUgLQIs5HFsVTlq+bnk4f/P5hio20BRusqrkjOnZKYXyhw18b?=
 =?us-ascii?Q?2uO5nk3Hw6K3kNOwfhjWwWZFYGz/2EqV20ilO+j4j8K+5Xt6t+ptLEk+5bBY?=
 =?us-ascii?Q?PmHFeOeBQ7qwZi71zdmNhy0hryjZIIyRpuwlmY92ibuO7XVUx8pB1Cr27vR3?=
 =?us-ascii?Q?Fv94bK2N8x7t/wUJy4gjyLvP8retEshaJfOkzfWWmG7Pjq+mFtGu+VWxty7z?=
 =?us-ascii?Q?oLjMP13LWqSzbFyucL/rHWZAFveE+wkkJWnfjRWuv7XLeeZRFahdMe1mBEGI?=
 =?us-ascii?Q?AhWSg6/NEQNf5tVaP726aQfOJ1zCBvSs+m7VHukoSWxfH6C97qGDgphRIG6v?=
 =?us-ascii?Q?LZbbYUVK5hr8M3uuezqBOo1jsNwNUBXk/VjPwvFH+g2lDtta+zGpxUfF3lDP?=
 =?us-ascii?Q?CQ5Z9gA0ixtj0+K2EHb6NSXHZXaL+SRiJjlE7IqNg0Zqcs+pBDY2WnJ1TvfL?=
 =?us-ascii?Q?by3A2Lil9YNBr4jRpz5yqNzhMO1fulHfifIp/av3ApPPhCJMAQFnH11oWwLv?=
 =?us-ascii?Q?MZ2y1cLN+HpaMjfVUD4XJuHcO/OTLuRj/vXSfYzkCHi7g5i32iZqgseUzQ0y?=
 =?us-ascii?Q?zz9HRiMelODU4wOWU7NKPyzNfhhqn/sMU32C6PB2UnoMFw0xAsNc8sMOpgas?=
 =?us-ascii?Q?/7OWy2FrDMqmxKQQik9qUxNo4e+cpqOPqLv8auJD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4d8133-35ff-4d03-36d9-08dde0161e31
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 18:19:35.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xo75NnozI7//bPVXG+53CfdVOKjXj1PSD6q97WJAibt7xutCePMbjb4wK96yKR3ujKuMOEtS9Ny/HtjQuqdTaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9014

On Wed, Aug 20, 2025 at 11:22:16PM +0530, Joel Fernandes wrote:
> 
> 
> On 8/19/2025 3:57 AM, Peter Zijlstra wrote:
> > On Sat, Aug 09, 2025 at 02:47:52PM -0400, Joel Fernandes wrote:
> > 
> >> --- a/kernel/sched/deadline.c
> >> +++ b/kernel/sched/deadline.c
> >> @@ -1510,7 +1510,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
> >>  	 * The fair server (sole dl_server) does not account for real-time
> >>  	 * workload because it is running fair work.
> >>  	 */
> >> -	if (dl_se == &rq->fair_server)
> >> +	if (dl_se == &rq->fair_server || dl_se == &rq->ext_server)
> >>  		return;
> > 
> > Does that want to be: if (dl_se->dl_server) ?
> > 
> 
> Yes, that sounds good to me. Andrea, while you're at it could you roll this
> change in too? I'll pick up your branch once I am back from travel next week.

Done already, have a safe trip. :)

-Andrea
