Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3010F51AFDB
	for <sched-ext@lists.linux.dev>; Thu, 15 Oct 2026 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068443; cv=none; b=tlh81DVKkFMDN5qTaz5QlngZ1XFyfh7IQDanF+HLb+g1nZkYrrJPpaLkDwoA+3IlKlQqq9SVCrY3YUiNQi63j+N4hOuusv+FwLr0bDesvw5oTDoBLl7PT5hxyNjy0cde+9w71zLj/Yat3QXCNKVodyEipvXdulSSVjypuhUrg6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068443; c=relaxed/simple;
	bh=YOJ0YMc8La/jNcbBC0eUdhX9rRv/PsC7NYu9zK8QHpo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=RIPlXKhoQqtKieE/DvQ64VA5l5ULr6C57LTuqoQZD9kWIkmXKAWu4HlKaayXDUaQC2MmW/ChrT4S+GNyAKBtqDueh64U/Z0EOQ2L9T49ukDTW2iScUmq8HRKYplqblkm6jC7zFxFGeW6zFqmtYJxSiIEC+4prFHo+41f5BHBGYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oV2PyAfP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AvXvFg/6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oV2PyAfP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AvXvFg/6"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jgA73510187
	for <sched-ext@lists.linux.dev>; Thu, 15 Oct 2026 12:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=03X9ozMJs7HECVlV9S35rD
	2v2kz+KS+stKRC+hGL5Ok=; b=oV2PyAfPfzGtrc7hvmdJtmP5SJLJLKjQy418xP
	Z+kWiGqQRZLvz1CQdQc7/p5RSYXr3+oa0l+++ib2hEkAeAgPVTyCajRzn073VlZ/
	/FevjlIm2dZzhG6ngXOXr/+4JYezdpmD8cjPQqPp/oZkQn6oqtjlfgVbd9hPK0Zh
	WxBPLu7DQQ98unmB0doQk/n72JhJyjZdl8DPmQT+6aZvAHgiDekIWb9D591YOKrf
	FN2i7zWdPHFkxgvgfIqUxqIEsyE9tHZz5NfscqOiUlR8FG6EIx66+RKFS9q8cec8
	jUox++DFFZ57vNT1cz+On0z7t7nqqJY7KieXhDeQcDEtbQVA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdsa2e5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Thu, 15 Oct 2026 12:47:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e9501034c4so20832195ad.0
        for <sched-ext@lists.linux.dev>; Thu, 15 Oct 2026 05:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792068440; x=1792673240; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=03X9ozMJs7HECVlV9S35rD2v2kz+KS+stKRC+hGL5Ok=;
        b=AvXvFg/61va/Wt31QQZUiU6A6WQHgCd1TdR2NFRVZOJuJti0Gjkbyb/Sm2huEKh1qQ
         7xKuyo7akYdu+YZv6EvtY46EJJ3PUb2P2WPZZqF/+Lzt4e8dM82+ZwWqfyuloDDns4lj
         NZxcrt3OQPbnAgFhyBZVezdE4qgytxeRwt0dDk7JYOCJk/Vg5qur1CwPgV2OuRPGZnng
         BQD//Xbr0CpmPbCoRJAqR+zsZtKF1nQKRToDlHXPPS8QIDPi9wEi06/P0L6dXmavQQcb
         JgwxjRNVRBWAFfU9Sb6xQgHhhdzhZddAJXRhROEasbrQ6HKjU0i68cPGmrjpzlmTklh/
         a9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068440; x=1792673240;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03X9ozMJs7HECVlV9S35rD2v2kz+KS+stKRC+hGL5Ok=;
        b=aBhEi5KxFImaMiFj7iT9o5PknVWHQ6bwmlDMGfaGzeWqotXi61P2i3irQ/LB5TzHYa
         aS0oiELv1hzQf282tsxjkWC5GnM8r5ByVpGfbjQPGYt+yUG2Hu9dA2aKsAmVdsSctEHZ
         ZyUPLmvvUkgBFAHIIvWVn8uiUOoSMcCwH9XrPwUBmp0yfTOMhPCjMmpZW3DizMmPDiv5
         gXPGA2uP3xMHunestjk2riko1szcgqYTzG8EMDTIiNxcVi+vOoasioRXB12jZl3KGveF
         5w2Dv/1nRRddLu26FU5tjmj8rb9BEyxQGJB25H+18G+DpsvVebHBNN/8Cymw3x8fsW51
         uIQg==
X-Gm-Message-State: AFq9FYIVlDlPmphaxP8+7GY2xH0wCxO8V14Ev6hmHe6bLiXUyZHm6a41
	Q3oEphINfpgv+7wjd2ldr/+9vc4q0r2euMmB5LCwUrPOuQvQQ+4wFVlaETCXhiGgXO5CAHhvsRt
	NQCHA8O4zpdvfLnjVxF/DvChXnKRla+eWEGqogFGtzwQZ7JWoFAP/u0dLSg6Aw2o=
X-Gm-Gg: AYBFou1OdbofDo4WWt8ienSVcdZTzIdZCtfC/xwN69NOWUA+1oBZTxcXIIGdhZaGhDr
	Tk20jmNeGcyhN5EjtDRLgEZiIN395BElRFqRveF8Oz52DvSOxi256ZlB4dRMwWWZoLS3zIE5fGi
	YKersyxc8Np2BALbFyfb6dtrTRbDZi8RhtYE+0qe3iee5TSlmp2+MQ0d4sQJwuUfCJnnKjsYOof
	5c0DwX8Ia87f1aj3tqEy/8gdWkPsaCYurghUMGaKin4Glxm2sOFm72KVK1LOsHfVhStiIgJ0mi5
	anbLvV8hML/9KHqO4H5kMrJHMM+agIcWy7wmuN7+jBH7TSC9uHpnaiC8BPvF8bjKvKkivnY0rI8
	Zk6BHBLBeponaLofvuczIfS2J2PTNKpgjrhSG5mzug8KzoxUBrZ85mIAbfMZeFYXCvZo+
X-Received: by 2002:a17:902:e892:b0:2e7:4a2f:68e6 with SMTP id d9443c01a7336-2e842e1363emr183533465ad.39.1792068439767;
        Thu, 15 Oct 2026 05:47:19 -0700 (PDT)
X-Received: by 2002:a17:902:e892:b0:2e7:4a2f:68e6 with SMTP id d9443c01a7336-2e842e1363emr183532555ad.39.1792068438410;
        Thu, 15 Oct 2026 05:47:18 -0700 (PDT)
Received: from [10.133.33.55] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421b160csm82646435ad.37.2026.10.15.05.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 05:47:17 -0700 (PDT)
Message-ID: <6b295276-4f42-4f46-b5a2-50c3ac83b412@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 20:47:12 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
        Cheng-Yang Chou <yphbchou0911@gmail.com>,
        Emil Tsalapatis <etsal@meta.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
        trilok.soni@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
        abhijeet.dharmapurikar@oss.qualcomm.com
From: Tengfei Fan <tengfei.fan@oss.qualcomm.com>
Subject: [RESEND RFC] sched_ext: Support RT task within sched_ext
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tuGqbfTTGULV2ZBe7_NOnTVVWrUevZPd
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad0cb58 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=OGjWj8McAAAA:8 a=OhM-RmH_1B9f-UcPyl4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=UYjydHh6ynBBc6_pBLvz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MCBTYWx0ZWRfXwJ9tS/69o0b1
 edqBH1+9gwNOxkbCQcvm+lXvx/Oj2//dSHZfDgBU52LzEZ5bhZ7gMrPmUhdedsO9Rsz6aCx6ca6
 Tg6P2FAMDV+uAkuR1CGViF3BLCYpXCgM4hCuigkn23GkzMZuwwHFriKX0qFjqyrKtjWc6AbSg2M
 YxbR2gouzIBt7lR/d6A5x8XifO1cOoFNGVVvVCNi4nrh+0iYtrW8PNEIZv37bGUdomYAQ+cmkJi
 C/qqBt2pyI/TTxP/N4V8OANpIk9wwIar6JeI5Iy9dSxCi8XSj+bgjvwFO691yMR0pY5zVmy+1vS
 +WvJ+3EfakXXLUC6rSM75KOP4FM68QeuZ1RbD5KU27KtBxbRmLHUD3btO0EFE4xDb1juysVnG+9
 QQn5r+DetUq2NjzXCXg/OFtkrG3wjdCjGIDFuGjWoL9IZTtKN+GEHwQhI/7LIK/pbfAVRPAktUF
 zyHKNWUV7BN7d874ZwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MCBTYWx0ZWRfXwE9UmAtvrtXw
 ocKhZqZIoLXQkVym/2Uko+TzFBtQcS27Dd3mAt2p+q6VhfKFfY+owZ4y3Ls94QihV1aCy84kLGM
 q+q4aq3uIO1HDRN7tsbUtWcng9ukkUY=
X-Proofpoint-GUID: tuGqbfTTGULV2ZBe7_NOnTVVWrUevZPd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150050

Sorry for resending this as plain text. The previous email was rejected
by the sched-ext mailing list because it contained HTML.

Hi all,

We would like to discuss how RT tasks can best coordinate with sched_ext
for cpu placement, cpu balance, and sched load reporting to schedutil
governor. This RFC is intended to continue the discussion in email list
from last LPC[1].

One of the options we would like to explore is allowing sched_ext to
schedule some explicitly selected SCHED_FIFO/SCHED_RR tasks.

We received feedback from Changwoo that the issue is valid, and in
LAVD sched-ext, they tried affining RT tasks to a limited set of CPUs as a
workaround for the scheduler placement, but we do know that it is not a
flexible enough solution.

We also had a discussion with Andrea Righi, that he acknowledged that
he understands the scenario and current problem, and he would suggest
not changing the current core scheduler, but instead using bpf ops to
bring the RT tasks under the sched-ext control. We are trying to explore
more on this path, and welcome to suggest or comment here.

LPC topic:
[1] https://lpc.events/event/20/contributions/2561/

Slides:
[2] 
https://lpc.events/event/20/contributions/2561/attachments/2025/4612/2026_LPC_Support_RT_tasks_within_sched-ext_.pdf


Here is a text-based description of the main idea presented at LPC.
If you already have that context, you can skip the section below.


Background
----------

In most of the Android gaming, video playback, and livestreaming test
scenarios, non-RT threads work together with RT threads to construct and
consume a frame. Finishing the frame on time without frame jank is a
key performance KPI. A balanced workload across CPUs with fewer
unnecessary CPU frequency bumps is another key power KPI.

More specifically, taking a gaming scenario for example, UnityMain and
UnityGfxDeviceW are the critical normal threads that have significantly
higher load and usually run on the most performance-efficient cpus in
gold/prime cluster. Other than those high load tasks, the other normal
tasks mostly have similar workloads.

It has RT threads like the display HAL tasks, SurfaceFlinger, and the
GPU related tasks. Those RT tasks have workloads comparable to those
of other non-high-load normal tasks.

In our tests, sched_ext runs in switch-all mode, with
SCX_OPS_SWITCH_PARTIAL unset. It schedules the non-RT tasks
covered by this mode. SCHED_FIFO/SCHED_RR tasks still run in
the native RT class.

Below, we call these non-RT tasks "SCX tasks".
SCHED_DEADLINE tasks are not part of this proposal.


Observed problems
-----------------

cpu placement:

In our tests, RT tasks can run on CPUs used by important SCX tasks.
This can cause the SCX tasks to be preempted, waiting longer to run,
or lose cache locality.

Here is a diagram for easier understanding:

         RT task + important SCX task
                     |
                     v
                  same CPU
                     |
                     v
               CPU contention
                     |
         +-----------+-----------+
         |           |           |
    preemption   longer wait   cache impact
         \           |           /
          \          |          /
           +---------+---------+
                     |
                     v
        SCX work may finish later

RT tasks have higher priority, so the preemption itself is
expected. However, from the whole scenario perspective, better CPU
placement could reduce this interference when another suitable CPU
is available.


Load balance:

RT tasks can be scheduled in the same cluster of non-high load scx
tasks. This can also be a preferred placement decision. While the
load balance within the cluster is also hard to maintain.

We sometimes see RT and SCX tasks on the same CPU while other CPUs
can become idle very shortly. We need to check whether those newly
idle CPUs can pull and run the scx tasks. While if RT tasks are also
in the same scx scheduler, it is easier to make decisions from a load
balance perspective.


sched util calculation:

We also see a difference in load tracking. Our implementation
uses a frame-window model for SCX tasks, while the RT load signal
in our setup uses PELT.

The SCX task load is flat and steady, while the RT task load
sometimes spikes. An unnecessary CPU frequency bump up can be triggered
by RT task load spikes.


Why CPU affinity is not enough
------------------------------

We could use CPU affinity to keep RT and important SCX tasks
on different CPUs. This could reduce the time they compete
for the same CPU.

However, CPU affinity is fixed and strictly limits how tasks can move
between CPUs. If the number of background tasks increases, CPUs perferred
for critical SCX tasks may still have spare capacity. With fixed CPU
affinity, non-critical SCX tasks cannot use those CPUs even when doing
so would help balance the system load.

Ideally, the scheduler should be able to choose CPUs dynamically as
the load changes, while still keeping tasks within their allowed CPU
masks.

CPU affinity may still help, but it does not provide the
flexibility we want here.


Possible options
----------------

One option is to let sched_ext schedule some explicitly selected RT
threads together with SCX tasks.

This could let one scheduler choose CPUs for both selected RT
threads and SCX tasks.

For example, if other cpu is idle, or running a low priority scx task,
or running a low load scx task, an RT task could use that CPU instead
of a CPU running an important high load SCX task. This could reduce CPU
contention for the frame important KPI and help balance RT and SCX tasks
across CPUs.

Such placement should remain a preference rather than a fixed
rule. It must respect the RT task's priority, timing needs, and
allowed CPU mask. The other CPU must also have enough capacity.

It could also allow RT and SCX tasks to use the same utilization
model. We would like to study whether this can make the load
signal more stable and reduce late CPU frequency changes.

Another option is to keep all RT tasks in the native RT
class, but provide enough information for the two schedulers
to better coordinate CPU placement. However, this would also require
placement and load synchronization between the RT scheduling class
and the sched_ext class.

After the LPC discussion, we'd like to explore option 1 and use
BPF-only hooks to achieve current needed RT tasks within scx class.

One option is to have all RT tasks with a priority lower than the SCX
  helper thread go into sched_ext.

Migration thread, sched-ext enable/disable threads and IRQ threads need
to remain outside sched_ext. With this option, we will need to verify
more common scenarios. We can explore the first option first.


Open questions
--------------

* Can sched deadline can used to optimize those scenarios?

   It is possible, of course, so we put it here, welcome to share the
   possible configurations of which tasks goes to deadline. However, here
   we discuss only the topic of plugging RT tasks into and out of
   sched_ext for these scenarios. For different scenarios optimization,
   there is of course no single solution. It still can have different
   scheduler optimization to make a specific tasks a different sched-class.

* Other ideas?


We would appreciate feedback on the problem, the possible
directions, and what we should try first.

Thanks,
Tengfei Fan

