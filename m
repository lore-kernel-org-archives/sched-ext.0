Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B03734B198
	for <sched-ext@lists.linux.dev>; Wed, 19 Nov 2025 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763548692; cv=none; b=H6ajXIHTIYsmY9h1y2NBdxBswiFpMPCPacMAQU7j2W23ZiCrxwy+clD3qVL8ypFAJZyp317iYCQJwrsXE4G1bixf3rjMBWQT9N3yGQXVmhUJ7IyxfGBNoXCmW8FWMXi+MO1E2Un4+lorfk1XM/yRtS16R+4GttK69rrYiG4wW7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763548692; c=relaxed/simple;
	bh=eiog3ndfOqDIeJBLItbgULk373m+BKkCisDEYozuKzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WIVsKEerD0OJY/qVS0k3muC9hozIXkrI9w0OYcKqhii1eXayG9S5iSpx0ITKBSuksdij+3NZbZm5uBAlo0fK1xOm9oatSJF6/XV2p8i/4eXAkqA94L1IYnfe/C9gvQnKtKJwrfxXSnOlus4gQLgzjearS6Mi9e9mWIwSH2cK+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UJps2FLr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UJps2FLr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ8Vwlj021316;
	Wed, 19 Nov 2025 10:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=W+9tCQxLSI/hfhj3zXtbxh24I1jQwyniw6z+cxVcl
	/Q=; b=UJps2FLrovX1JXd8/SzUpMZRLcZEwWmFftFbDr2joNbs7w0CnP819LmOP
	0LeF1X2Yy1yfl/U4F6oSVf3GSO+y3x3z1ncm63p3g20budx/wKJHsjkhcRK2SYVx
	L+Os/8GI5Bz1FQD6uZpNgjj3LzT5/xDQFVtF9CHJJ8+JD0AF22mxR8aDa6pTnk8n
	J6tX86zbrxqfoA9Zf2rdxbfaurs5SClWcjfP3Xu4l3zYwJfcOX0G6/V401ayb+Fn
	9qzP25f4nat3JWHo+8fNLyukGlEAe/I4K0KTL0wivGH9qwXBi+G/exSAAUS+oA6m
	OQW7ZibZXWU3GoTPLIalTPvR8Ingg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmsq5ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 10:37:40 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AJAbdc1027927;
	Wed, 19 Nov 2025 10:37:39 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmsq5yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 10:37:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ7AEGs010506;
	Wed, 19 Nov 2025 10:37:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af3us88af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 10:37:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AJAbWxx36634884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 10:37:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E7F220043;
	Wed, 19 Nov 2025 10:37:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B743420040;
	Wed, 19 Nov 2025 10:37:24 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.120.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Nov 2025 10:37:24 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, samir@linux.ibm.com, sachinpb@linux.ibm.com,
        tj@kernel.org, void@manifault.com, arighi@nvidia.com,
        changwoo@igalia.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com
Subject: [PATCH] sched_ext: Fix scx_enable() crash on helper kthread creation failure
Date: Wed, 19 Nov 2025 16:07:22 +0530
Message-ID: <20251119103722.309211-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KvVMsPEZ_7ZRxtT4zFzVhQzypPfY-rih
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=691d9df4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=z3hIvhuMv-q9_2ygNyAA:9
X-Proofpoint-GUID: 1Wmn5-AbUAK69HsbJU3eppPy_WsEV1UG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX/w+6aUQ+kD2s
 M1+qNBTQriH8pEeV41oNm3yLL0IFQ6AK0RodqUh3UND6bIWkzWaQ5naQiDjefcPXLLmXIEThRVP
 zC5pVU89clSIxzAIThwDlSOiIq7NRv8I5HOOFnTmzfewj6HYIVIVI0hPp7XnpRLtfdiQ1l7Ytlm
 P9flfPTx/jFAG7yrdVsUNpFp0xqvl3sAG1Rnp14cCamDR8/f2KRI6zky2NVhsMJxTwSLQHqJhqs
 h7YPdG7G6rLFyEdSwzWE5JR6d8huKcrjomClMdC3ZSN/Rblj/IAIdfNzXSQwd4Nn8rORsxt3ccL
 moWBsAr3qNH59W5uoLf63MXumv1hpAag7Yoo+18Xk7tfuT9Moa1eB51UZA7uHZjSA89YfnzpSQd
 5dB1i6ZwkktbK590zxFJqGJmDvE9ZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

A crash was observed when the sched_ext selftests runner was
terminated with Ctrl+\ while test 15 was running:

NIP [c00000000028fa58] scx_enable.constprop.0+0x358/0x12b0
LR [c00000000028fa2c] scx_enable.constprop.0+0x32c/0x12b0
Call Trace:
scx_enable.constprop.0+0x32c/0x12b0 (unreliable)
bpf_struct_ops_link_create+0x18c/0x22c
__sys_bpf+0x23f8/0x3044
sys_bpf+0x2c/0x6c
system_call_exception+0x124/0x320
system_call_vectored_common+0x15c/0x2ec

kthread_run_worker() returns an ERR_PTR() on failure rather than NULL,
but the current code in scx_alloc_and_add_sched() only checks for a NULL
helper. Incase of failure on SIGQUIT, the error is not handled in
scx_alloc_and_add_sched() and scx_enable() ends up dereferencing an
error pointer.

Error handling is fixed in scx_alloc_and_add_sched() to propagate
PTR_ERR() into ret, so that scx_enable() jumps to the existing error
path, avoiding random dereference on failure.

Fixes: bff3b5aec1b7 ("sched_ext: Move disable machinery into scx_sched")
Reported-by: Samir Mulani <samir@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 kernel/sched/ext.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2b0e88206d07..7fc0cce68a1b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4392,8 +4392,11 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
 		goto err_free_gdsqs;
 
 	sch->helper = kthread_run_worker(0, "sched_ext_helper");
-	if (!sch->helper)
+	if (IS_ERR(sch->helper)) {
+		ret = PTR_ERR(sch->helper);
 		goto err_free_pcpu;
+	}
+
 	sched_set_fifo(sch->helper->task);
 
 	atomic_set(&sch->exit_kind, SCX_EXIT_NONE);
-- 
2.51.0

