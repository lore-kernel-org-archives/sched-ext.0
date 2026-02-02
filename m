Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6C25A359
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770047571; cv=fail; b=WxaTrJR6pzarOaWdfKEsO6vKdHVAmP1EWQ+IhOvgvCaNGc9p4InPO3A4NIhAiOyHZHbooSWaeWZbtGwVOwDXJIh3bItbe6keu7d8LLF5L34XfdndkSn3smFXOcRFsJZ/ZvvXfYTrGi/1HmlPpHh0QQ7mHcn+l0Zh+7yUTu0Gnvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770047571; c=relaxed/simple;
	bh=D0y+T+C9zFrgW6pXcerp1Tlj2Vus1sEYIhvL51ikTGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iKMqPIdfcru8pjKfTNwnFr7/WEIFYsS9IbKQ6yVxQ79fTdIeLfXA9hxi4uL5vYKVa0QDLXXtx80GqGtDX3JLGasxUy888ncYzHusrBhdJcrdjQ4UoUVdEn7x4LlbqHukeyegH4AHUjmNJssbJbjyEIP3Wq26rp6iv8BaD5NSQWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DFWMrZWZ; arc=fail smtp.client-ip=40.107.209.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DFWMrZWZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtRkYrW8YjR8AOqoYz1cL725CZndm/57bwAcUEOAtJFEoHHSDxQwlB/2M/lbu2ISvXkKZ7+ff6Oa9q3ApDd0ByIHrs/+7yNQYiiik/tIdILHQikJ+xeKflQ5Q2M53d6Y1YvGqP9HYRRMPz048WMnA3o0awVftulbye0ARkrk1dlXvHqzhD55Dp78Ez8LtWXdXmILMjRn6+LMe/MPN3KVlupsCM+9cC9mLVzJtdw8cM6F+Oz529CIlQeaU321X3jui5x16Vltm3WWYRELxBZzsjz06RjCSdxiHdd3R+CJyDRHZAQlS1vLyXHUa2GwPNpQ394fA/DRq/JMlxCUcEC0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5ntOmlbTf3WH1cq69GWXlCyJGS+gpsC8g2qKXCSz/A=;
 b=tmUTV9VND7rKTNtQpLKDm/aMSdRJ3/kv1q90zLIPK/2YRSs4W3k+oQXBsO5/AovKlSzBzdlx52EuO9MpohMwgtEIcK4xvx5Na1CxlZwL4B9HsfftUS8H6hMtlxGUPz+i7yZjKnHIYBzXlLhV1AiEJXYdjRRN/VJi6X1TCUfga0HpO6IG+gOaCgbC/hRe02ttn7kdl7zKfLPJAUMFi51BvKuw4QtPTuaX77j1ki3d5wWBnDYRrCn8OzryUmQisjjnMQI4dFw26XFiFZBxfD8r5OMUkXfFX6mo91KLQJTOHVsxPJN/wgvGB55GjA1O9tAd7ex0n+OgYKMPDa7gNtBWzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5ntOmlbTf3WH1cq69GWXlCyJGS+gpsC8g2qKXCSz/A=;
 b=DFWMrZWZ36C0dXnlSj29KXS6xAd2jWoGMF1vynD1vilGrraPKd/T9mGI1RnWJKM/Y3k0ugFgRDdRNAajfCO4UUBqIaZZbyhossHlXFrEH+hrRwHFZfU02UCUngeSbQyM4SVfJrbDBxilWK9dgU1VFP4XCmRvYLBQCSV9uoaRKJY32ze5XhtJt33IuweZvwoatviNc93/iGIs9YV7m0cCB+PPmZzsNNuwSaKfuMjFZyHr4enq3TNnoa0dPo1ruXcMSGc68y+zCDmLYSGx1TPG0hI0SwHeKedIh3iP9oG35hyqwXRB03hYC3Eb6Ksw6VE5O5vPK+/I6MnYMhmoJcg2Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 2 Feb
 2026 15:52:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 15:52:42 +0000
Date: Mon, 2 Feb 2026 16:52:37 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYDIRQkwstFxPleQ@gpd4>
References: <20260126084258.3798129-1-arighi@nvidia.com>
 <20260126084258.3798129-2-arighi@nvidia.com>
 <aXp9xSpYhaysBLQ2@slm.duckdns.org>
 <DG1WJEB6B0AC.151EBIUYXCR55@google.com>
 <aX-QxWngrRcOj3PT@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aX-QxWngrRcOj3PT@slm.duckdns.org>
X-ClientProxiedBy: ZR0P278CA0082.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: 861eda02-4d5a-4646-0a3d-08de627318c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eE2okKRebX/h694ncjMBJ5ONO5H3zJjVAOdcHepgyftTU55qSPL5uk8ifGUq?=
 =?us-ascii?Q?JMols7Ny50Z4LOYnrSJCMXJrAUIy5L1vhV9TMyNP/RYTZo5JfknsYGOXtHqi?=
 =?us-ascii?Q?Rwu3pmbQ5kLOcL4M9kYV3xSMLFQowqIDXuCrZYyPgmITR2Bx+5nag/jx5/77?=
 =?us-ascii?Q?XE/lc2XC0M1rkHEw8lQ1gGtdHf+l4fxRD14ZxBfoym8cYd9Ke+kxEIz1dRF7?=
 =?us-ascii?Q?gxaWCxv8MkUS4t7etU91TMeIDbNNIPAR2YHhYEgDADsAdj/XmMwDLzbfeRZ/?=
 =?us-ascii?Q?yt/UnVodwhcwiDFsdabAeQ0quqS2VaSoAzY8HbZ8QX9pISQaH9wPl0MaQKz4?=
 =?us-ascii?Q?sVCMTSGRr2lGawCI2PMwfFPrcDKqUJgZDPjR9pfU7bE00coy7L2rQKEPEs6V?=
 =?us-ascii?Q?/S1cHN/bnejIJcYJB0mTSI0clMJArEZVIacJ79C4JD1Y3IwHB8GHoX0tFIPe?=
 =?us-ascii?Q?1LDr8/vQcMclFQl/bl2yqvrLKZMvnW7G2jP3S2iDGeUqQAJqVHudOx9Jursw?=
 =?us-ascii?Q?QV7cxDHWbhw7b12fsekey0dyjHlWm7id5Qu/hDbzkjvVpbRGXmMcV04VT4Aa?=
 =?us-ascii?Q?Nk+Wv46i4rnlFRJ8Dcca9iUOpo7IG13sN7qYzcrUoIs0VTeDuTBQHdovKcOT?=
 =?us-ascii?Q?vVNZUkxrg9k7rtyHJSz+7Mij4YQ3igwrfT1xYgydRMH0u+gU5RsD09BchI/6?=
 =?us-ascii?Q?PA3bWvODVl2o8UIZorKi3QIiugyjpIJXn5oEzTB34emnR+Kw/VyYZPT/OeLq?=
 =?us-ascii?Q?c6N0otp8e5YonhE3x6AF5wECpTvP1WhXz3NHfWCnelP2syaOCNcU9E9cv/Fl?=
 =?us-ascii?Q?PEVKA6W/JTIbOg4WsIS1DHUED8PVH9hcRYp6SBmNE6ac06zcxe/BlkGAlUd9?=
 =?us-ascii?Q?paY3zu/36slG/unXz7vsG1xZHPuLa1wouJd+FV8pZ5riLRHF+Q6MfB8HeCpL?=
 =?us-ascii?Q?Vt8k0AXHZoyOMJO4jTvDnyWYqB2544fZ0iOAroTDsBbieHfve42yqwum0Odt?=
 =?us-ascii?Q?gO96fzmyM5Dge9uHjvIiTPbIrQUfZPMx6mDUEA7n/9CS/I6i+Abq+az8HLU9?=
 =?us-ascii?Q?iRNaBCm+4wgUCJF/671Ql2VdEC2eDh3h9JcS6DCV1oZ4XyJUEKw5kFCNqH0L?=
 =?us-ascii?Q?YiP1CmEUV5idXSeLJl67g1LkYR6XC/D6LQXxUe0cA+Lf5Rg32Q4BxFDIuUdZ?=
 =?us-ascii?Q?KNneKNY6q7h7alU7vGJv+by6LY2ew/g/17OxK4TtGnfzMZy/tSWln48/icTs?=
 =?us-ascii?Q?G20BH657E6qrSeD/c1gdZUFu0WidZkwf1qAGYGOXAiuwWTv3A3zHa4yVXt/H?=
 =?us-ascii?Q?BT9iSJukAa6Rj3WEZdaqHoQvRFlJAPSPcmQcRJ3KLCri0feBXTV0TXsn1i47?=
 =?us-ascii?Q?iZphKCc8JMDyzV6xeX8fhvjvYrWJOlChaBQD+W9S3FvD5+PDki2sbIBQowM7?=
 =?us-ascii?Q?J+KypWTzQyiX6QlgWKBDb+GnQ7q5MVgz9a3XKqo2Bd1lrHNYjh2c4kpc9ITG?=
 =?us-ascii?Q?HKuAg8FZcVraOTXz+1cpDEG308qdBj0MpicCXBQo5qvbqCdID/EX3PM0sywK?=
 =?us-ascii?Q?LoSnbKX1NYLS0Kkd6fk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6JSr3kMr81AEev6UAuHPQDGAZpXLe26d/YjBNUwD1TaiJz4SSv5t+p60HVdS?=
 =?us-ascii?Q?cYvSOpg+u8t31FZmIjup2qJgqOHVJp8lR656VaOWSJm76miR4etvO/30D4Gv?=
 =?us-ascii?Q?TOu/+Kmzn3AozfvY+X3vprscL39hdiQ64UWnRs/qaC6OdwScOHjG7W+5OrUH?=
 =?us-ascii?Q?GzvGVT6iGmYSLgZxisbKh+mFUFLf5wPona6M1FXAsXElW/wMHWLSCYS8YNHQ?=
 =?us-ascii?Q?Ll4O3+4pkMx/OLY2hU3OC51YdI+lrji/0I1odnH9+P14nE7B0n5Ln2NyoOPm?=
 =?us-ascii?Q?keRXI7uvXoWAFb+zk4vpACBb+grZUg0SdKoZ99PX47QVgn5+KH0v83nrR9FF?=
 =?us-ascii?Q?9oBqs8JpfwYIl79wpuuT6rYLub9Jyx85quwiETqp7DDmqQpAXNBBDf+s9icr?=
 =?us-ascii?Q?S0Dnl0ZoNpzygPHMKDtCsYvpjTqwRCdGPlSlTQdfzGZkWby2CLG2P+Y5JIPA?=
 =?us-ascii?Q?TOiG0fGy4fX72ZkYyUCZxhRCj2wNim0pX1jU5sqLoYaQ3eExu+jAMhANviJX?=
 =?us-ascii?Q?ui3w/4NVG79Cs82KyHShxriDmgd71+wXB6gUzn3qJo9UavV7thxUMcRtt0/s?=
 =?us-ascii?Q?oOgcplIYi+ymeugsMrcN4YH83e7XnEOajlcRkH0QSDH4LShAHNeJnb69YHgE?=
 =?us-ascii?Q?WinXxa63yFwvLpdRDbv0AETgJjym7KOs/7Mautopqg2cmldHWWpAslPjcWa7?=
 =?us-ascii?Q?MFZ0JVvi7Q6Q8V9IJzDPkKyHuvLFORGYMla8Yk9J2qGvescd7aHJW2B1KcZK?=
 =?us-ascii?Q?1T2dHZcHDb0gZfi6YjPlkcViYkgqtFZ755Y8fQsH+zzZgXq6PfNexuHLgm77?=
 =?us-ascii?Q?rWEsJw5Eo26bzIAH+Yx40fY2HNDiOEYBC5ur+jcdAEOMScm/89td38g/UWQE?=
 =?us-ascii?Q?Yiudq5nClGatZE9A684xpeAqspgGubMaO95omlDiG8niyfIc/v54/j+yEgbJ?=
 =?us-ascii?Q?2xNKLwcxoBlx3yNogfdShVceNErWqtq01MHG2nyqG3wlitDep2X0EyLLone/?=
 =?us-ascii?Q?nKz2hcMQa2XFU1Ct5h72bo7poVF8r2/4c5/+u2LW+JsDnIfX9akK1pM1lT2F?=
 =?us-ascii?Q?pKFySe7emV7ZICEdvLaVkyCW0dVGvR3tdi8+XKeEH89xQ86UjTRJKDlu5Opo?=
 =?us-ascii?Q?xaiiikqRvNwtX2qb/OIRKSLTNIk4Py9yLQbouKtBnu02wuoopP8ndVXAIQi/?=
 =?us-ascii?Q?X3PZSMZUQUVMEt14+2vpNwptPMKMSd4RhlSqRfQ8trQCGT3+ZfVri/553zNR?=
 =?us-ascii?Q?M0GB9bt65zgBVl6YpSUMzUgkum0zcSesDpEA+dJ0otQuzd+cw0DgDI1+ToSV?=
 =?us-ascii?Q?w1X9Twm1WqJ3lKYPQDfxSO6ewyvSY1pr7J56XDt8N3veyqWVxFUKxPb5RNq1?=
 =?us-ascii?Q?SQqXgC4vfTuNoBaPvh5jeenQtfFfrlRU7p3KLO528fTG6QOglq8Ar6J3HJSV?=
 =?us-ascii?Q?wrIXYFWHHR8sGITwSCMXC5Y/WwjhP9/C8b957YGfcnVkvWLmBiO7giLpZeId?=
 =?us-ascii?Q?cedkgsuh35ooqfo8H1nB4JfSjyM4eyxClhZEPcTW/9Z8ZZH0yQ/VSIdtTwez?=
 =?us-ascii?Q?TbqMlR9sZtiM8NGH6SeCVnLkSkuQjm2GGWJVxT4CSguvkxQvz3bae4MPNcYF?=
 =?us-ascii?Q?muWUcetIA2C8tqA6IhQRWcgrxiyiZ+K4jvwoOnV8VjwkUJvP6+b3kTTkn9g9?=
 =?us-ascii?Q?gUAnWYJJwafmN9HnDuOUI5AadOs3zdJdS3wfI2snLaY6tHHt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861eda02-4d5a-4646-0a3d-08de627318c0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 15:52:42.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQEgP81+J02OzC4T8sghaVzLFInkIxBS/fJPa9egqVfP7/s4VEYgIWwK+TxwL8o8eJqK0D71mwKteZyY2w+fLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195

On Sun, Feb 01, 2026 at 07:43:33AM -1000, Tejun Heo wrote:
> Hello,
> 
> Sorry about tardiness.
> 
> On Fri, Jan 30, 2026 at 11:54:00AM +0000, Kuba Piecuch wrote:
> > Is "local" short for "local or global", i.e. not user-created?
> 
> Yes, maybe it'd be useful to come up with a terminology for them. e.g.
> terminal - once a task reaches a terminal DSQ, the only way that the BPF
> scheduler can affect the task is by triggering re-enqueue (although we don't
> yet support reenqueueing global DSQs).

I like "terminal DSQ", if there's no objection I'll update the
documentation using this terminology.

Thanks,
-Andrea
