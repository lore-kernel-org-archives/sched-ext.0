Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792943582;
	b=pz50SD4ZwK94PFmlLEEuOB2JtUpVvuPDjRd/IHLa/sh3sFoL7LTMohZ803fub9N+KXJB
	 ibL1TM8SA/xMzsSgRJ+epXkXFndNiVwtNPnm9nSfZT4dJSDAdF0BOEMJIBiD9gL7oL4lw
	 xOiqdW3WwJx6MrkSuX9lOFIRVH+M9rSY6xPMu3jrWDnFz6DQtokQTN43lrvNAHCdiRoxQ
	 Nx8wSOw+j7u9iFmFLhUX4miu5w+QLy5QMFLBMUw/AG+TlZSW4JIbv+PNTEu9EgGuvZWNz
	 7GuXXDohhlGOvDi0WdfgVR6rYoe2Tx2Fo7aPlzCH7QqlzRkU2XlwoM7QWbSBxJu+NXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792943582;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=sjWgaO6jh1BPiiGiVA4rrv+INReLKQS1gl9MIhKgpaE=;
	b=VjPFNqtNUihMKu7WkgqFCN0tUe5plnOXFqHh5exGwhkpeEengSXVlOQJMertUWucZRUI
	 FXx014eEez5/DuuFftwCLqCDKZf9+esE/weYGLAtPLbZdSuiUyD2htwGcX+9LIiRu0Anx
	 5CuzIDUzTlNDVtBqVPBE/GkKNY63yau7h3tj/Mhs2njIWQ86ufiuhIjDODjnaj06PB3CA
	 AD5/z9P0k4JJ2zhHtOeTU58carZtPY3xQdKyghFHFA26bf4LI2O9rZfLlWNkOD6wzoweY
	 1eRQJEU4dRpG92vXDtSRo1xyok8xb1betzQKOAL1ETcR7SG6YyqgzK3ovjrfVV1q9Pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BckUBVTV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.36
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70276606A31E
	for <sched-ext@lists.linux.dev>; Sun, 25 Oct 2026 15:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70276606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BckUBVTV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTPOPoUAwV1RB4YreGXcvfUY8JgJpKw3Rsu5V6LBNlc8h9fTHe6uMglshIbshYLHbF+lZVj3IpNyVTdjbz+ckeAH86FkukqZHp+WTHfMz53uymACSSZMHOrMG4CGHGNJGNt/M2RAveJCgIXFZ+NTlaZXQUgoLklTwAazqx+ZRwI6Al/SbBi0Lw/azRx/hN8QLKfGLs2Sl77l7UK1DbkyQ8T7+PVw5YlpYKXARWnrlcpn6rrUzwpbDTl0XCh9bsfSbg2bgnKFOY7MqucoonxAZ9fbyBUkvsTqtVC2GAVC69wZu0AaFNpJlMtDJrVQY99kYiiZ+yXUd0PDcSfZYmHqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjWgaO6jh1BPiiGiVA4rrv+INReLKQS1gl9MIhKgpaE=;
 b=NvqPf1pmryREkFRPe1SVbmqiCX9nr5GBhjBXl3wnE+ZDbLJqWAGVDnt+EMZseddHbdUTf5Ay1apK5Ap7FZ1fPRwVUb1v5nQ2d+DdRHpoGzePcuzHkyv4zLMffsIBOYfFnD/BQW3+VbdXTZ5sNKzUpDqT3AB2rv2jeWTFObXby3L5F8u0GujIjJcPjgA00Byk/4gCt6wDQXtVYJyPPzixRywEqlf79r2MUEOumjjqpiBQma/bbGvcnRVRnEesGcAvKRyw2ZnO5IZp4E1hSB64duMJvlOhmPFgvAFku6g73l9qhYXxzBBn4XXAJWligjKroMPdaANkbxnOS0kkSXs65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjWgaO6jh1BPiiGiVA4rrv+INReLKQS1gl9MIhKgpaE=;
 b=BckUBVTVvhs8yyfR9XDpZmkE0xnXaGTo9KkSphIA3WQriPb6kXOH3ln4DS+J8l9HsfLUocqnNtr7fqYSjiC6egzalEK+Y7pvJ17JnUtDAiOJ8sbINkUd1J06HeIxTvc/NE+RwNFDW6/0EDlUQ6uFeEM70wEtbnpmEnCxbB+OBhxbmKGysRTF9LkhWBcze9YnCqG3Gcn6OqEUP+60kaY/NhfWnixmXlDYmmQGAhIJV7436+cjC+ST5eo9eH5YrWZsGn6D5+2r2pTuMTi6vFnH+r0E93co7Uu/P2eO8XkzWUx4dqOCdWF6pHucjKtUB7EZN8bcPGNVMk3d5SQM0ROdRQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 15:52:58 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 15:52:58 +0000
Date: Sun, 25 Oct 2026 16:52:51 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 19/17] sched_ext: Fix the stall watchdog blaming a
 bypassing owner for a stuck task
Message-ID: <at4l0yXTk7T_ouk0@gpd4>
References: <20261023175608.4120910-1-tj@kernel.org>
 <20261023200640.272834-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023200640.272834-2-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0044.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::13) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: 60748129-91c4-406b-81e9-08df32b00ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|5023799004|11063799006|4143699003|261021121427099003|10067099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	8Jh+hEcjokH00yvcVFhNUUWPOHwS+9Q5Ox5RWg0YhZmnaaFw8MQGqh+c+2OuCh4dwTCzgWt8drh0N7acc4ziXJkr1HSEADCqZTd6HcsNNWQNtopicuGkjxlFmujeamTCGBCqtv+BhjhErwFyAvx0X4w7T4iHQnwf8p5eYVn0Ep7XiW/gQVixB8bsgM/J4YFDLhqtwoKpbkaS/hFxuk4W3+5I4CzX9slIm5YN9/h1bUNzYoVqzEYVUnRj+4SMQGR79J//MlMu8OZKBsrc/93lwr8Jb29nJa/Dnd/mF/nahDnlVjw6doumAmzZXbgkYPLMIMrnXvi3lMBKlNfoCKv0lhuEUOQTeRzWLaN5ieMGwEyAiGhNOUieM8w5VwiCurXqjPx48FPJWKBrLcgTBPQ4KZS+9MQtJ1nEihz+vRMpSYaVAppsUZ97MaE+3ZdnoQU8GiBENkrzt7dFGoCfsY9swhE9rZyr/NLwyF+5cCvUgfVpBx45Qc5rjlhahXWfdn1uv4TOZroLvQPETRFWMNSM12UBJXizXCC3nwrr+xJiHlRKpDZzQYzIKPyBGsPkwWlA6D+1/807EVIMSJI32jCmGDwpD9BJC/WVpn0z0tb6eSBdfliYnndr1mFtBs7FlfjWuE/Gphkg6/nhzn+8dvh9ZYcHh+WrY2CS9Bp78SySj0c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(4143699003)(261021121427099003)(10067099003)(261022075727099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BnX8qaOKlZVlsUCidPvyADyIZgn7Hfz/O9NpIuhXh01qG4vp8zUli7XvAjXO?=
 =?us-ascii?Q?hM5xTchKPfYLozVrchJP6kSiVpWH9vPcdgXJ4JrWi/bJYOA/Xy/ry7asTt7w?=
 =?us-ascii?Q?UXRoUkmdsi0BL0dH1qGl9UQOKhVNxKxiCSlq0mxaiWxGwlULD7Iu7HKzfBK1?=
 =?us-ascii?Q?yG4mI/lMATFC8cFOkSC40uXUw5iMyvhQ68czdyXxr1Hrg7DGJIGotpqP1uin?=
 =?us-ascii?Q?+F37rL0hdCfBaFnPN4HyYTx+ZNA1zFJuXT3X5bjpTbRJMtTtqfaLi+2yGFIT?=
 =?us-ascii?Q?Da7kiDlHPx1tTGDkzpnmA8JkOwECUoiN3luMIBqoYkQ9p66YUx4RVp7v2uYW?=
 =?us-ascii?Q?koqZ25jB/VySm5tUOQJBaYveIwFtd+ddQEtKLaxKKo4v6nAV31hY2WNEol+D?=
 =?us-ascii?Q?P6EMcuB1evSK31/H71MS0Rb4MRFv5JNr8JRkqfqowlQjWcdqr4cuCNMz74Of?=
 =?us-ascii?Q?q6CFmLyYlJrBlAdO1KkkgeshgcEsLuh9NDiONT23OvJ5TD/a6gyZ+F+PnX9s?=
 =?us-ascii?Q?I54TAkTEbAb29HwEESN6VHdqn8WQqIzTb69VByrze48SKBEahuExZkhQ2iAX?=
 =?us-ascii?Q?fvMiJfWXpnRKyzuOCLWGlO5rI9MeEWwQ8exoqIn5V14Txevd5qEg8LGXWm57?=
 =?us-ascii?Q?ozX4Nv0ogsJ8eaBT8Qu7Yn2rsWb/vzbczMbMYiEsdE05lXUPOsrvQBYr+m9U?=
 =?us-ascii?Q?kiN1/m+C03/L93f/OufvZHU5e0Mkbou/h0ohnnTJL9nF1GcYS8/gHp5aeva4?=
 =?us-ascii?Q?QnvGjUZ/RuhoJvpO3p7tcDSLHbwoDainud/6B2SXPjOps1dFuhzQxM8nUmqo?=
 =?us-ascii?Q?saKLbRBBDHbGozPaptZtwr23vAuAh9xs/FuPiV/zX2WSYLlJv5FRm60Eq3hA?=
 =?us-ascii?Q?/YmLFztrkPZjrZvMpHwaEqf+xY0RxkYKdYANew1103Z53bj7km73X6RzckBx?=
 =?us-ascii?Q?jDQK2XphIXvHF+XySzewwWWW/hv6fRQbUScbWGT5AKZQ+EJ+RtG066BFFquE?=
 =?us-ascii?Q?yjM2BkYZsWJvgkr8B5HELbU8V6PVQmitfZAIdziiy7LyTHxXcwNjNa+fRG59?=
 =?us-ascii?Q?PNnbADeefbu6OAExA4j3dPI3Kk1gw6jbUIzDYHUb9PehqoHpjJdtBVUCFK62?=
 =?us-ascii?Q?aFAR/ElnH6HTkv4DMNImWgqyKiYl+Qbm9RQJ7QEfqt6A0ll1Lhj7ZooGJIE2?=
 =?us-ascii?Q?0emtHcPjl0tPlCF0RW3Xk0oI3611Gb6awd8w9sw0y+rzL9Dz9OWM7GmamcIU?=
 =?us-ascii?Q?bRxnpgUfF5FyedInp8kvuOSXZGsgSc7HEKF3aLYIzFqnfZMmtMLV5GoFIFBI?=
 =?us-ascii?Q?+IvMl/rA9gq5FkkcS2CC5qtwYttEivqjZ6KFu3z9RGdK+4fHySw68TB16Dso?=
 =?us-ascii?Q?bqziJFaRNhlrx5NB1vGFzIkoyKEyonRj2krSLjaBGhLHNf1IHl90j1lMYvnB?=
 =?us-ascii?Q?/JzUUf5DoJwNtT36Llnn6HfxuAhkgEKt4vyggdwxt1nPUmcs4Q5sFw7g+ROZ?=
 =?us-ascii?Q?dpNJ5fLivi+IYLgf88VbRoTVgx0pTVKu8PaN2LgWrexfpQGpCVsImKlK7Ydk?=
 =?us-ascii?Q?XnQrMSfxP0i/TO+3IYDUrVviJ0J+PHMmov9V5Z1c1b5E4A2ET0lb0RbnhGWk?=
 =?us-ascii?Q?ijqU66xreW8N9v5VPutC1I8IO7MTfq8EyAzwKesoAz3j/1fJ92jmTfS5nM9z?=
 =?us-ascii?Q?K69GP3/DG7vAsbb+2eCKZXFsnRtljdvfyNquRH5uXBj5GOdy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60748129-91c4-406b-81e9-08df32b00ad6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 15:52:58.8292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUB3atpUH88BlMPiFT0s0zDZ32zZAo0Ct4VrvcM5WNvyYE7hdObu2Pm5cDqU0EqXpVE3Xy4fBpVNZ53pNyOnjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509

Hi Tejun,

On Fri, Oct 23, 2026 at 10:06:40AM -1000, Tejun Heo wrote:
> check_rq_for_timeouts() blames a stall on the scheduler whose DSQ the task
> sits on, and on the task's owner when the DSQ has none. A bypassed task can
> sit on the rescue DSQ or the local DSQ, and the blame then lands on its
> owner. The owner is bypassing and places nothing. The host, the nearest
> ancestor that is not bypassing, runs the bypassed tasks.
> 
> That matters when the owner is already exiting, during its own disable for
> one. __scx_exit() on it is a no-op, the watchdog still ends its pass, and
> nothing is ejected. If the host is not running the bypassed tasks, the
> owner's disable, which waits on them, may never finish.
> 
> Blame the host for a stuck task whose owner is bypassing. Ejecting the host
> re-hosts the bypassed subtree one level up. A task whose owner is not
> bypassing keeps the blame on the owner, and with every ancestor bypassing,
> scx_exec_sched() gives the root. A task on the host's bypass DSQ already led
> to the host through dsq->sched.
> 
> The rescue overload accounting keeps charging the owner. Overload going
> unanswered while the owner exits is acceptable.
> 
> Fixes: 2c91169377f4 ("sched_ext: Blame the DSQ's owning scheduler for a runnable stall")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext/ext.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 8241cf374ef9..ae5e8861ca0a 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -4376,9 +4376,16 @@ static bool check_rq_for_timeouts(struct rq *rq)
>  			 * ancestor's bypass DSQ while the owner is bypassing.
>  			 * Blame the drainer. The local DSQ is consumed by the
>  			 * cpu itself and keeps blame on the owner.
> +			 *
> +			 * A bypassing owner places nothing, and its tasks run
> +			 * through the host even from the rescue DSQ or the
> +			 * local DSQ. Blame the host. Blaming an owner that is
> +			 * already exiting would eject nothing.
>  			 */
>  			if (dsq && dsq->sched && dsq->id != SCX_DSQ_LOCAL)
>  				sch = dsq->sched;
> +			else if (scx_bypassing(sch, cpu_of(rq)))
> +				sch = scx_exec_sched(sch, cpu_of(rq));

Should we recheck watchdog_timeout after changing sch?

The stall test above uses the task owner's timeout. So, a bypassing
child with a short timeout could potentially cause its host to be
ejected before the host's own timeout expires.

Thanks,
-Andrea

>  
>  			__scx_exit(sch, SCX_EXIT_ERROR_STALL, 0, cpu_of(rq),
>  				   "%s[%d] failed to run for %u.%03us",
> -- 
> 2.56.0
> 
