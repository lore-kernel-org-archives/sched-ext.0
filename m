Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010037.outbound.protection.outlook.com [52.101.193.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9034DCE0
	for <sched-ext@lists.linux.dev>; Thu, 29 Jan 2026 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707999; cv=fail; b=E29d57WSx8obJv8n2c42vNxAVCZ7XtEhJVd+D65q9GBvJ7LjcLHxvIUQibT4fVsneSzCyQ38AOWnSAXLxMqO2iaqThAigYtuSv1NOE4t1IvAjTNoP8cqL04GqWUS4mWmtbO3ElB/FsloE+OKY8+yHmAAMX+A/eNz802m1PPZXZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707999; c=relaxed/simple;
	bh=Lix697pLm4M4Oxtp1Ye91fOvwKlH6wiBzorT3qQYtGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gkyimv4+L0pk8IAu4bmo1rCDU4d5Syy/PMdAjcwG2tx0DZtV/hjcaWKfqAheCWD8wZh3PjhxjNSYbZ5QxSUXW7czzbfZ8J3rcmeNR3exGVCewmLQkynl2VVR8bHPJMpUGTe9LRog4wys+sY33MHdg/3Ff232IroJH4u9Yc7ZT+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PwiJ4psf reason="signature verification failed"; arc=fail smtp.client-ip=52.101.193.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PwiJ4psf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+n2qup5/89oEklEwNdphZ+GGIEUxgUI7e3vVvAEN8OJyN3lzaKZ7k85eo/dscYSfEnsbdc6p9yXE59GeP2O8jAJArBv2uaOzKNAdzK2+es7Ij/YqeBTn96PLHZtRZcqCCBhMLR9LMLN6xeROmOA+w/guB7p8RKmy50dtktgYlYKRqL0MZ4+7igyRLpk0wDk9VmLhCIiRv3ful/MtvgcKou3CEJVF3GpUo9S5IwuZhJ5fTbL0AUtsVCBireGZVZvl3JFzkeTuxzs5FDmayVEfSmy8H59oni06hgl9Ur9enMDhwbOVYl6+Y2WbkupZ7xRi6hJPYrtZwFjCSy99UX72A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFgHOPdQnmt6VBF9wS6hZBkhQw6AYZj4yjNKK40jMhc=;
 b=KUUF4rFt+hvitPk+0yUQ/qDJsDdAY0cPtCjfs1pYOmc+10W/qpVhjhefQOl9kN8fWQdX+sMO5sBHKHf3awAAlmKpwlUHOmA1xY0GPJAmP5b6rrFgBCP+u/rYWZGQX/pPmil97ISWiqC4bOMXsj8QmXhvY1pkJQJqDg6oKxteovLB84asXxs5AB0hm57i6W/xzbDuvWKMOpc0DXckh8xMCsDq1VjP1nT2cY6Anvx6spq1o6in+KYFDk6frHZ8ugQzI2gPvAVYgCE4E+O+REPa20Rj1e8vjEozU9J2Lh4l9ACXXbM9fqZZOe9Qq6EzL4fsahYvj9xLfwDAnCw+5ipRrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFgHOPdQnmt6VBF9wS6hZBkhQw6AYZj4yjNKK40jMhc=;
 b=PwiJ4psfyRiiUQ0mz2q6MNq6fgp1pabNUcwkQ+nT2go8+bV1KHzVM77Nw6G/wD9Byo0h0YBDk51g4MybQITf3VXqV8nkb7gxcM68LAIIRFkhJTAp/hysg5M2/k5F7DnK6c1gUDrJ3w00uz/X9kX3YSrHcUXLxg8PnYi7kIWl3CGkXmmPnwmtcct5UlRle3f2sE1HMa4AWSvNOWBKOPmq5Y/82sU3b08t2q2FxyEigzcnHnHrXjYjl114qzAcxXrBK3qBPchluXa4ESJscJaGGIRcnTHlAp0LeGYvn51830ycSxwd2uHhzZjQDQLSPCUTKhmvgeCuQ1+aqNV1rdsxoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 17:33:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.010; Thu, 29 Jan 2026
 17:33:11 +0000
Date: Thu, 29 Jan 2026 18:32:58 +0100
From: Andrea Righi <arighi@nvidia.com>
To: gmonaco@redhat.com
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
Message-ID: <aXuZysNQCVrfFzx7@gpd4>
References: <aXeWnzI3ymUSm3Cu@gpd4>
 <cc33e6e3-3ffe-4ebc-a2e3-7dd7afe13538@redhat.com>
 <aXfcGynN92kyw5Co@gpd4>
 <9b8c90b1-9247-4159-9bf6-72bd71bb74a2@redhat.com>
 <aXjJG-72XEqvaVtL@gpd4>
 <be763631-f677-4bad-8285-69dbfe29db54@redhat.com>
 <aXkJ8_zLVSuToLxe@gpd4>
 <45e4dc7a-f261-46ec-8973-0fb8d1f7b0b9@redhat.com>
 <aXoSFOONWJmdyCQB@gpd4>
 <b7ffc7e6121320d29cedcff0e2b68ad76c8e2775.camel@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7ffc7e6121320d29cedcff0e2b68ad76c8e2775.camel@redhat.com>
X-ClientProxiedBy: ZR0P278CA0103.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: d189378b-a770-4acc-7a35-08de5f5c7950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?hNujFi3h4ADpkO2qvdwxcvlHMd2F32AAIoM+IQ0PVH6+7QyB30z6+ovC7T?=
 =?iso-8859-1?Q?tuTWAJNqCTgGGhbUxKRf/JGmgY7BMgdu2zdFaZv4XVXMp8/C/e5OoxrRBm?=
 =?iso-8859-1?Q?xvMBHkU+EnF6d2tiYGyjKG/8zkzfkxsND27/LnVEyFrdooXVtFvG+OT00z?=
 =?iso-8859-1?Q?LEXGq1xSG0kR/P2zhr/1vgyiQAn0/6ALrqwMRZ7AFyGEhOwLL6Djan9jTG?=
 =?iso-8859-1?Q?Im0EPChwF5goVLiH4CM0ME0JI3xxliYrUlmlzud53I4/lS3WYBm9a8/vlv?=
 =?iso-8859-1?Q?lwFOqhhwUZzKfLxrw/O0R/mq83JRT0nL43U774Hs4Lxx0QP6YzQiv5uUD5?=
 =?iso-8859-1?Q?ft96askt1GqNmg8/7bn+nD2xfI/7vQnDcEMY2mZyS1hPr8l4pG5kFp0Qm6?=
 =?iso-8859-1?Q?Rc6Un4BIs9jzwKrGxNp+NaAiRymKnCbSD/AfEm35mVvzl1y0veJs4MdXl9?=
 =?iso-8859-1?Q?JxOf5KuusLwODfAYoeOoSs2EHGFfb0Pt230s2/wJXGXihfT4an49CEEtyj?=
 =?iso-8859-1?Q?p9yMnlNCY2lBBKzW5QA+dY4bzw0SsxJXJ0i7Tl2EO9OcQXCQRKqAN49NRJ?=
 =?iso-8859-1?Q?Rmqr0ljqfzthOZB/fmVSlA8JHH2lEyWmi7xBhOeKVwHONwODU1mVaVaJC3?=
 =?iso-8859-1?Q?PwjeEt4NzSujjFtNKuXfSIzZPh92QnmzdQrn3BEGaUbcbmTyZDptiML3/z?=
 =?iso-8859-1?Q?s+bHbhTYQeDLc0sLGdbTIP7PI7XOpe0KyNROcb7zjEXvIuCSdQcApsJCR8?=
 =?iso-8859-1?Q?uGDYw1eRvL7si5HjPrHBGjwil40rfn6R4pj/j7bu6ZZP/Xt8JM0mn1Xprm?=
 =?iso-8859-1?Q?D+CyHKCjahkvZ0iPyu/u5JExUp6qEOvGYkRATJw+rpCqiQDNLvEmOqeQu3?=
 =?iso-8859-1?Q?2u5rP1QmNMcHfe/DS30sZ1OXDHeX4R1D3SS2ceAwTH7H12TxGDxmr/J9Oq?=
 =?iso-8859-1?Q?G+ThuV9EtF0SS+amKEArfP8VtiFeDwwRdNQat65U8xVRQlNDg23P4y7wm6?=
 =?iso-8859-1?Q?BMSD+NGRgfkYewHEtLmhzj7Q+3w0IwIIA4q2HEJDqG7HMbHXGEehrSY4t2?=
 =?iso-8859-1?Q?Rmh3EQFq02c2SM4PoUpBwKhK+0TNA4nISIIuxZtTQBW81Cg/yqNDpbLx9v?=
 =?iso-8859-1?Q?d7Ry9XJCmqXcZ13mulIhKd1fJGCO1WZrA2wMEnvBi7HBXPwHa1KHdMjzLO?=
 =?iso-8859-1?Q?WbejuZcNjyppTsqdMEf0AkVu0lTGF0DgCK5lhEwaA7LquhIpmOohezUYho?=
 =?iso-8859-1?Q?G5w8Wklfxu2TkX6eYvjACM757flh7kXnVOIRizfGUrgGUI6eXyzTs2RoYG?=
 =?iso-8859-1?Q?o85vV+F3m8EDgxPH6ga8RqRFzVT7CSqP69ACLcMfjXfRYjaN8ZzKh+EYxw?=
 =?iso-8859-1?Q?RBT1RrNmFskQPJG3fCmRS9b9+TeXKiEe+lz05FcoYT7fRqRJS3Xte6Mh83?=
 =?iso-8859-1?Q?J0RC3kEpV3i3Cyqjk3HAuSMXQSumwDWNRPB2sbHMUYDGPT+WrG15nK3Y6M?=
 =?iso-8859-1?Q?8tnmbPiwVzWp//pFC+tknojObM6KEAwPKReRVBIaMgmkVtfg5JdBCrNsjZ?=
 =?iso-8859-1?Q?W0XvwQm6ZeIPeW4fuKhP4RWawAq0D8KylkJeC0gWD6/T8EbnqQPmJjttUc?=
 =?iso-8859-1?Q?hAZ7fEClXTLs8RxOFMPySosJAv9gxl3Nop?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?YRRaif3+kH0BJqSQpRvGsquYWUQcMZCJLR+Ao5ymfpiOrcYj6feN7NxgM+?=
 =?iso-8859-1?Q?IuPjlidaRI2Qb3X834qtsttqoInZfoCD32fs4DjPOPEo/gkWwlwaBcNkxS?=
 =?iso-8859-1?Q?qHF/FUe/WmrQvQCTLFP22KRIjwa+CqMmH0VjHbVH1rg8Z5RL+ot8YqGOmK?=
 =?iso-8859-1?Q?9wmhrbAYQccYhxUjikKFxOkMaqpRLNtPo8pfcdL311c23WRZvgfMFeA8Bd?=
 =?iso-8859-1?Q?agTuHfsMoCYo+WiWHKndGYFv0f4YPPFCQvx+LU3XHFq3nrsA/ifUYlFdaW?=
 =?iso-8859-1?Q?Dmfkmzd/U8i+lJEDVxXkExNwzMz6GVPwZZYHvVyUxiKpDLnE0f3tO8ofq4?=
 =?iso-8859-1?Q?3twrRgBQuSJYoOyVINeGPHyQ61F2EZs3phjqnp1CucKhb5F7SJ357V0B19?=
 =?iso-8859-1?Q?iNbnUL3Cvtx1XGUvkHKAB2Y4V4EOExFjdcANsOVy3b8Jsj3lc0hnnm3yxo?=
 =?iso-8859-1?Q?iJSy8dbMoDghyS9ZQASxTB7BrzT6/NXcwlRr6zhwSCO9eMcaSh1GO3phV/?=
 =?iso-8859-1?Q?7ob29hUODorY1om9SAFHULPm697mL3AS8jylhGWkiCcUQ8REHUaa05P1W6?=
 =?iso-8859-1?Q?RZ5LfieMHrq7rOBn+gNpjJPdYvST5AFTZuB391/GdABYXXfSte/Z/MZRyP?=
 =?iso-8859-1?Q?0Bppx4gySb9YTooPxGkj1oqb7r8j6ZPjbYFl9NxsGgPSKO5OV7WyEIHgbG?=
 =?iso-8859-1?Q?CqgAboVRwof8gBt8hjtESJPjv825E2vxytYDFSSC3x+jFOa0K2AiaZNB6f?=
 =?iso-8859-1?Q?nNVKJm3nV/oAOQVrL1YcEdXgRzN4+XaLGj3QZVO8PjOopGZ0QZ2vRv5mqj?=
 =?iso-8859-1?Q?1CB8CAxXpQRum0PLvaLxryRbnKjpVI3UWTubHuAjDH0+IVSdeBZ2Bc9MYr?=
 =?iso-8859-1?Q?wcaL5Pm5S3fLZHJPR9YDUo8UefgLUq49/RunC2cChACfSJZ/6oOK+QoPFo?=
 =?iso-8859-1?Q?ygWo+Rc1F/PLkG4ByXIvibC55A18QLNQKZZY2HiWhQJVObVLC3XDpgiAxr?=
 =?iso-8859-1?Q?gQQhqmWWzag5gPcsCx9pS98Oav0l1L7UQpwefrQBui1e4GbsErwNrbR8rA?=
 =?iso-8859-1?Q?E9yE4bTN3aiqMPg7m01knQD55be1gWsWR1n5A0Xg/QhkM04cl4xk1T+Ymn?=
 =?iso-8859-1?Q?ZlXbPJul6LWuHeTp9EDKoFDByQTghXHSxIgZBl1w2xZ3U9OQ3GA5peHGUZ?=
 =?iso-8859-1?Q?gv+WGmUpb5bJaqSOorWzN7/ntxJtPExZOIyJRjm8fGfXG6If43PamsmCI5?=
 =?iso-8859-1?Q?X1jAQxeZZ4l91P5Eru9hdr5jWl4UrlXkN8TbBZpl1qnHuL5keIhD2MMXD4?=
 =?iso-8859-1?Q?KKiG1nj1HurkYJaHkHzzSmFD3QKuVO37HvWner12cOnnvGgIjGGzt+/bqc?=
 =?iso-8859-1?Q?VBSQ+3JhQoH59BGRSjB3OBMi6NN/V0c2PzaAdvpHaDMXFaqpjlIq8JMvO4?=
 =?iso-8859-1?Q?CQyQKCSZnxFTDccgLN6VG8wsIgozff6BuagcIj4RR41Ham8cWq8Qe5Rj9U?=
 =?iso-8859-1?Q?IQTCUPcVnN9fdbPAwlFCFdkQzVK3GXbCOhqtzlUp387vGDAi5Y75c9mSXo?=
 =?iso-8859-1?Q?bgsXOFRaTKYnj4Zd0+xHH0Mj7i/Ae2C1epNozNlWbrkhOpuCgnmaAhAV+g?=
 =?iso-8859-1?Q?QZGGsXmOlAaWcn7Hh/hNibjc6WAIuYOD93pir1sUMedls7zCMlpDM+pKgx?=
 =?iso-8859-1?Q?36L78pyj7GC8+GYawxI5gr2DkM6huX3o9iihxxu/td1A52RtWMKVSG3i/W?=
 =?iso-8859-1?Q?iEAAf4h44McpS63Jg8Bc0os8RPpGTvLuQKWpbjmeJMT3a3+/pHHcO/HAsz?=
 =?iso-8859-1?Q?WYCeL/9rtw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d189378b-a770-4acc-7a35-08de5f5c7950
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 17:33:11.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWt8ly6cDqwybFjHvJDdW6oi8yK3ccFZS5sJSTCFd++Hvb0bnfIIcTWDiabsViQQSN0dsjkjS0KdqcoTrLmhNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6838

Hi Gabriele,

On Thu, Jan 29, 2026 at 12:48:35PM +0100, gmonaco@redhat.com wrote:
> On Wed, 2026-01-28 at 14:41 +0100, Andrea Righi wrote:
> > Just to make sure we're testing the same thing, I'm currently using
> > https://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git,
> > branch
> > scx-dl-server.
> > 
> > I'm running this test inside virtme-ng:
> >   $ vng -vb --config tools/testing/selftests/sched_ext/config
> >   $ vng -v -- tools/testing/selftests/sched_ext/runner -t rt_stall
> 
> Well, that's a fun one, I could reproduce the same failure you
> described in vng on another x86 box.
> 
> The arm box (bare metal) I used initially still passes just fine all 4
> iterations of the test.
> 
> 
> On the x86 box (vng) I tried different orders of iterations (where the
> original is fair-ext-fair-ext) with and without the ext server active.
> 
> No ext-server: the ext iteration fails and breaks also fair (unlike the
> arm64 box where the fair was intact)
> ext-server active: a sequence fair-ext breaks both (like you observe).
> 
> I don't have time to look further into this right now, but it looks
> like an interesting pattern.

Thanks for checking and reproducing it.

Considering that these issues around DL server stop/start transitions can
be triggered introducing an additional DL server (EXT) makes me wonder
whether this could become even more problematic as we add more DL servers
(hierarchical DL servers?).

Considering that unconditionally clearing dl_defer_running in
dl_server_stop() seems to re-establish a clear state-machine workflow,
I think we should go with that fix for now, so we can unblock the EXT DL
server patch set. With that change in place, all the server combinations
and sequences I've tested seem to behave consistently.

We can always revisit preserving the short-sleep optimization later if we
find a way to do it with stronger guarantees (and I'll keep investigating
on this), but for now the unconditional reset seems like the most robust
fix to me.

Opinions? Peter / Juri?

Thanks,
-Andrea
