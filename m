Received: from outbound.ms.icloud.com (ms-2001g-snip4-1.eps.apple.com [57.103.73.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E7E495531
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.73.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953725; cv=none; b=q34jc4/G895qUNx9VzkzfNuk5xs44eOEoPDVpos7r5GG4RIp9CFpFqo1Bu0NClFmge0SB93eP0X3AlFXK7+CCPRzA9r/yS38SlWkm1+l2tXzMtsaDW9Y6Mb/yCWs1SCxn0SX2Gmm1cOsD9P4LJ1qSafDAW3Iy1gW01pshqMvqZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953725; c=relaxed/simple;
	bh=dyk0haMAiu492VXGhnXZvWSgKH+6BavoUsqJZ7QBhYg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Zclr69YWhtWfk2BbJXHM5GZqNeJgCuNcoA+t7MkrN70FcJnJ61aRPaerYPFd2OT65+TrWsywtEYS366qxZ4HHeZda/HP0BwRzcpnzfiPPGyVqLMGz+FbBUR1cS8oSqnzi/2l3jOzAjMbOZRYoz8p+mC+CDZ8ImhPYIWnj52TIcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=YXpgqxs+; arc=none smtp.client-ip=57.103.73.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="YXpgqxs+"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-20-percent-1 (Postfix) with ESMTPS id 40DBC1801175;
	Fri, 02 Oct 2026 15:08:32 +0000 (UTC)
X-ICL-RepId: 01a0fd28-ed84-7e91-914b-1d3b38b91028
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwORQFEF0oBTVIPDxRcFFofVgVyBlwKVwRUHxwXXlhVCQodVwJdEVAZGQxVUEsbDlwPS1oVVRcOAkIfUB9MFldDWhgcGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKHVcCXRFQGRkMVVBUEVdQCy9+JX5LYl4HKWM0alYCOnondTpyNnsibjtkME8dQQleCEZeXh8NTUMSQhUEG0YeQwRfL10XXgxeBQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1790953717; x=1793545717; bh=dyk0haMAiu492VXGhnXZvWSgKH+6BavoUsqJZ7QBhYg=; h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:x-icloud-hme; b=YXpgqxs+1Es9WKX9V4Y4xmu0bddXO5J6AcPqJ9pRPlDpYww7DjRS73oA66BfHKG5EW0ymhXqnIiosXfjAP2KDArnzByfkaRRBa+b2aTBQMy7g+sfpt9p3ytrFDkjvjyq+DITEtZq5ruc21YdRTF0bOd45d1B74aWnk3kXELVNJkv7Alu/9jMDsvJzwALqdo8o8LHhKeIDraSVwETorAYVoM+m9mYn6udsuPnWtOKLTwnWnHCVFLdMyBlxqAhIHAYHk1zvQNMDapMioKTpqgCxrbmPTuILlZUE1QiP7oOdcMv4CR+JCv2jYXpODxdnKylD0ryPwY5ZIR7fbklyqTs6Q==
mail-alias-created-date: 1621344842221
Received: from localhost (unknown [17.156.208.39])
	by p00-icloudmta-asmtp-us-west-3a-20-percent-1 (Postfix) with ESMTPSA id 2E86B180117E;
	Fri, 02 Oct 2026 15:08:29 +0000 (UTC)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 18:08:25 +0300
Message-Id: <DLUG3Q30BQDS.1WMLGJKNHOYPV@verdict.gg>
From: "Vladimir Vdovin" <deliran@verdict.gg>
To: "Andrea Righi" <arighi@nvidia.com>, "Vladimir Vdovin"
 <deliran@verdict.gg>
Cc: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Changwoo Min" <changwoo@igalia.com>, "Ingo Molnar" <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Juri Lelli"
 <juri.lelli@redhat.com>, "Vincent Guittot" <vincent.guittot@linaro.org>,
 "Dietmar Eggemann" <dietmar.eggemann@arm.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Ben Segall" <bsegall@google.com>, "Mel Gorman"
 <mgorman@suse.de>, "Valentin Schneider" <vschneid@redhat.com>, "K Prateek
 Nayak" <kprateek.nayak@amd.com>, "Hui Su" <sh_def@163.com>,
 <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched_ext: Drive the NUMA balancing scan for SCX
 tasks
X-Mailer: aerc 0.21.0
References: <20261002124559.10367-1-deliran@verdict.gg>
 <ar--fEmqMyX8odNn@gpd4>
In-Reply-To: <ar--fEmqMyX8odNn@gpd4>
X-Authority-Info-Out: v=2.4 cv=T9KBjvKQ c=1 sm=1 tr=0 ts=6abfc8f3
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=dE4redFb1YLfMu6vwQgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MCBTYWx0ZWRfXxCN10EGP1Nyx
 VIyU162cqXSF86cqFcli3NNSjJfaGXsE1RPyCTpw2rnlWAVVZ12fh2Y8cHEEW5yhc0DgDRuUzUd
 xq8noeUfDIRjJ6Jn0XqUYFVe/odRPDrx7k4K/CDRtmXEWZ70xi8KQ/aKtf4v9Xh3Ui07Q3v6Jo+
 16ps6EeA37XSF8+nLl7RDzRiEsjEURnz22dz8mEbtOYAwy9pMky8ggQhYRrEVVe1etGBVR5Kxwi
 KfUflBycWIkQqHz8z3821Rt/M7c4cJEhu8fCXLz+CusrBh9v8WOj14a6Gkw+pNkCCgrt4CM8Ie0
 zyeD0vUuh81nbn7Lo31txyTiKS/upL4ejtiaI1Uxg7yzrBuNgQbat8sgE5OnPA=
X-Proofpoint-ORIG-GUID: cAYmrYE7cbg66t3c0SxgbCsCH0bul3Ui
X-Proofpoint-GUID: cAYmrYE7cbg66t3c0SxgbCsCH0bul3Ui
X-JNJ: AAAAAAABop8ng4T/Ij9vUPqYKpvjDv4tMZaQ7/F0jRur5mSmgc+0aBGxFq6/3m+QKmqFPb
 ChD11xoR3Yuc3Q5ZbRdPvvpNxuRurwdhaW2rJ6NWi1QB+BbLtHzN4Y6Kx29AMbo2h10Ce2
 eckSMqPfwWlYVYYoAk1IL/XfaczWpphgZ7feEhoFUuvQuaTiYqQSF6h1NEPDd884ehrouS
 gu10ZqDXL0yueskSsnO4WSaURE1Cd6dDOKSvYItMbeUDrk81XVgAOr+XqPHTDMrfCJQg+s
 cPWldYnv785X8dGJfQL+6kIiZ/eJFh9MnTid2E0so//lXHcMtDoVfpOEg6Y8iOD4t18HdE
 F/eVixNvRynW0CoAdjqbPuNaZ/Ja+GhLkXLEHpxxOiqbejOFxHIebXYCTxlvZlZhlz1i+G
 rQaXylG69QYkSp42Qy45SBD2VGQV+0JHDv+In5DACGmwh9/tiT8Nqsy1HmmdAr3LcmNc0V
 3h/wbUn40SnZsM/eNEjlmGXIFEFxa7oIhiqivg3VJd2Ah3BvKP3vFO00JWvpXY+RLfh1kr
 SojlJERIFckBn8qIySCRHd3VNlhozwLKnB/YW5dfFK/0opvAZYKkjkI+lIj1AYhoXTfVY5
 4Dv7zLVMbJvblXIKNdn/NARfcpdPEOVz8H4jq3GVE1t8gJxGkkYf5iTht+MsyQLhrxSLPg
 Ze28cFTeDA4Ews0SqRYzutbCF7PdzIHJbS9Bd5ANeupxoE9NE02BoOshO6ZBwFD2ATsBFD
 /7+C7mNr5Q2ISEzpvEH8ChxaIi0A0dOLZDZE4nrpjBMnoA1j0v8jfmHm/yqEJ5NEs4FpPE
 G5CuFfuOWdY6ZMxPZ4fAh7ddV/wueVCIS4brzKTDpUGzKMIeyCc/fLKzqI+YU24ubmLSYo
 qiPkK5uzOPxpfV3sKFIZc817vWak+p1+bRMwCPc4yX5CesrDWmTCT0M3n4RyFrdrNo0SEC
 UunKRpToUYCz2Ua+EGkc2xjhFEIc9ZNOaOHBsd+41IE4hQz98zEijpW7XEs9J8EijJWIg3
 pgkgGLKT7MA5jRej7xNOOCIuVPIRxfvdl0VPiqOZmep+G4B711jNHDwmXcN+QQcRmjxftt
 EvvAueRwTdTXkOVwM8AMGYT6fbWKCXfNktmNX7BMmPopGn3Kw79nCuUe+5rv9/RSVJzg7l
 izTbhCvlMbQ/QlhWICjxNQ57enM/gUi47jqZopRoXL6dNe1+9d2L80B8F3vKtYWjn7HHJu
 uIMxLABg4VrPwiV+DOaLcCJlZpTdMMsf8rfW4Mf9cZeBR8SwNnN1EDSHgrmly1Q13CiIrO
 Ry+wMuH8Ja93U4q+gDr5e2tuil4RqdwLm+YNFvmsrMxoURYDyyd/BaN5TqRlAlVZ1Qo67U
 km/u7shLLR9THxsrrPfwA0/bL5EDFg==

Hi Andrea,

On Fri, Oct 02, 2026, Andrea Righi wrote:
> Thanks for looking at this! I actually have a patch series in my backlog =
to
> introduce NUMA-balancing support in sched_ext. It makes NUMA hinting scan=
s
> opt-in for BPF schedulers and exposes a task's preferred NUMA node to BPF=
.

That is great news, thanks. My patch was only a small sketch to show the
problem, so I am happy to leave it at that and follow your series
instead.

Opt-in scanning plus the preferred node exposed to BPF sounds like what
I was looking for. My scheduler runs on KVM hypervisors and reads
p->numa_preferred_nid to choose a home node for each vCPU thread,
falling back to the thread group's majority when a task has none. Under
SCX that value stops being updated, which is how I noticed.

> It also lets a BPF scheduler set a per-task memory target, which NUMA bal=
ancing
> can use when migrating pages after hinting faults.

This part sounds interesting too. Guests that span two nodes are the
hard case for me: today I can only follow the memory, I cannot ask for
it to follow the vCPUs.

> I can probably send the patch series at this point, it's not completely
> well-tested, but it might be useful to have it on the list, so that we ca=
n start
> discussing and improving it. I'll keep you in the loop.

Thanks, I will be watching for it. If it is of any use, I can try it on
a few hypervisors (2- and 4-node hosts) and share numbers for scan rate,
hint faults and time spent on the preferred node.

Thanks,
Vladimir
