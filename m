Received: from outbound.ci.icloud.com (ci-2007l-snip4-11.eps.apple.com [57.103.88.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9295845D90A
	for <sched-ext@lists.linux.dev>; Tue,  6 Oct 2026 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.88.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297648; cv=none; b=uZJdyEtjkcKl1HKwlEHVv66qTYVg8ZmCF/PzQ2mc0qHoT+e2IR9BxtcjW+ihgwNcg88ymweoPoLiHzdirwtJRJFZapGZbGGdarpVgAZsltLiJlS0Vi66QMAS84ySXc5lWnn4Hpn/O5GX5MlVgeDawQsifA7dRw3DxdeTsuDiG08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297648; c=relaxed/simple;
	bh=h/nnP+E7fe1nVoUD+2H9a5/ookyzyglbYchY8DE3q+0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=a03DiGSGib4Euo+Me81QCjpezDpEI3YJCt3auss58rSBeciqGLrC4HKMfIjZjA920H2TCc5tLvIgxdNtieHKxbp2p8H9bqYulIsalmWI0pIkXu9s4933RjgtNpttxTjYM0j9e2ceBYFm/LNwmZnAV8YrQKToa6RtXkms4lYh8e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=K3cCcf8H; arc=none smtp.client-ip=57.103.88.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="K3cCcf8H"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-0 (Postfix) with ESMTPS id 43127180011A;
	Tue, 06 Oct 2026 14:40:40 +0000 (UTC)
X-ICL-RepId: 01a111a8-da67-740e-ab91-79be6018d5d9
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwORQFEF0oBTVIPDxRcFFofVgVyBlwKVwRUHxwXXlhVCQodVwJdEVAZGQxVUEsbDl8GS1oVVRcOAkIfUB9MFldDVAIcGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKHVcCXRFQGRkMVVBUEVdQCy9+KGxIfylnPmcjflYBJ3lSaD97TmogYlsFME8dQQleCEZeXh8NTUMSQhUEG0YeQwRfL10XXgxeBQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1791297644; x=1793889644; bh=h/nnP+E7fe1nVoUD+2H9a5/ookyzyglbYchY8DE3q+0=; h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:x-icloud-hme; b=K3cCcf8H8F9+2HE3eH770sAVOMvbgSzpDP3J+evQzHdX9GlEI54a+gCsJkTOKu7MW8il98VwPg82YOaUJ4q/JfHAL8nEEh+IQspRfu1E3Vr9Q/kpyza0tyHlTfL9/nVwBtmnkTGxcLozQfMT3x2XMxlLeICEinh+DkdRu+tqaHFULNndqmZysRFwkAFgNIpRJE7/jC7eMMTeYUgLEbP+3tKTOFj3Q3yTo42dZRWwV7VNxIW/G1M9tH6O247Dbz0vDq0ghr6A5Gnw0nHAFd/apO1kQeYwJVvvWzhXfGDiTL948buOJCiXv7iM3TLJFZk4Y8/ymS069YBOZ0jWO3ZEWw==
mail-alias-created-date: 1621344842221
Received: from localhost (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-0 (Postfix) with ESMTPSA id 7ECC1180197A;
	Tue, 06 Oct 2026 14:40:37 +0000 (UTC)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Oct 2026 17:40:35 +0300
Message-Id: <DLXU0LDPUUSG.2JN9ZOB6YMU07@verdict.gg>
Cc: "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Juri Lelli" <juri.lelli@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, "Dietmar Eggemann"
 <dietmar.eggemann@arm.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Ben
 Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, "K Prateek Nayak"
 <kprateek.nayak@amd.com>, "Vladimir Vdovin" <deliran@verdict.gg>, "Emil
 Tsalapatis" <etsal@meta.com>, "Christian Loehle"
 <christian.loehle@arm.com>, "Balbir Singh" <balbirs@nvidia.com>, "Lee
 Trager" <ltrager@nvidia.com>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET sched_ext/for-7.4] sched_ext: Add NUMA balancing
 support
From: "Vladimir Vdovin" <deliran@verdict.gg>
To: "Andrea Righi" <arighi@nvidia.com>, "Tejun Heo" <tj@kernel.org>, "David
 Vernet" <void@manifault.com>, "Changwoo Min" <changwoo@igalia.com>
X-Mailer: aerc 0.22.0
References: <20261004072901.3579967-1-arighi@nvidia.com>
In-Reply-To: <20261004072901.3579967-1-arighi@nvidia.com>
X-Authority-Info-Out: v=2.4 cv=XMk9iAhE c=1 sm=1 tr=0 ts=6ac5086a
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=18byMXbjZilrT4O_L_4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1OCBTYWx0ZWRfX13+4m56Y4Qoq
 jnUay0jZoWCzOqfDFLgMFFWFcHymBFJ4tMkDMbNF8myNI5iZ1pQ2eua6tS8k/w5ulubqOvChFGk
 +3RSNHe/IDbVgH43mBI+jswXod8Pi0/Plr8EtoS81BV7961umvn1WlHzuhY/YERCof86ObXWwym
 wuNOMJnwtd8Q1n8tAEba7zMSClSgUR3g4Dc3T1STT/Yomt8JEDPdBXHOGXE/z8NtMYWuAmChIk7
 0ahwhO5EFB29lxMPnj96tGHrPyj4fTzUeIZj7UmFeFl4PXvAvY96Zv5S0vb87nsfcFV6GRzPRmH
 dBYfchWbmXUHxDK/nzx1Nc0TXcqkkKcJwUMbYfJbOYARKEgIKYFjYctKOIOcyw=
X-Proofpoint-GUID: KWxPDw2SAkk9Or2XZ9iIt51MAH6a4z5X
X-Proofpoint-ORIG-GUID: KWxPDw2SAkk9Or2XZ9iIt51MAH6a4z5X
X-JNJ: AAAAAAABdUn6sFf76kXbnKpVK/BgksrlIuwj927XxVR2yldzlkmoU7+msZTNypuq+kpmY85OVhgB4EnlUqyNFiEAv2XoQVjT9g3z8HAXooOhxfwRlOdZ1pyucqE8djkCyLeGsIvFecl8unajozkcjPpeNXqmO2kIrTXZuotIMzLGcWNoLFfUwxyBqBNxZuUvhl1HsEIg1TysBayiQDoNRAhKOmwbPJeoRXIz0HNvCs4iOho3iUdKDRn2GsJUy28fats9eS+5xoSpd3R/JMp9ac8tnoP4IR3YCAwEnvurD+jUHFkbbN1w3MhLcLtwHX2Npt3SQNLXYqZz6/+Kiy5lhlvPxo2PTzotLSHvuxsoglmmBLI+K+K8sBVAZMIGhnydBUitJA3x6HOKJalqiFloJOmxxrv1E5BYFc2N7CO75ZHs2qT0wBP8Z/8ePloP9Zb1dpG1Is98Aoyw3eyp9AM+mLTSiE9A1muVr38kb0Kn9toY7dIIBULrmAZg9/+SEeyv8N6OoJ4iiseQjV+fvWqNuhTZpNKGPO6nejxLnXSIFSGw/azX4RImBfNiXjMPMbG7SmjH2fo6LEJcFNryyFLCUZE28OJLgg6bIW1s509roSKR5GxM86Iaah/Mx2CQfapwtSU2SYF7dcAXs0GWqacmANwHn9dr+9akAWIuUdc1Kauwaj4TT/dyEu3eusT5DY0siFKvRqN5cl0r07nPyGpUf4oHhW3jDvGoIx42okl2BSybQenMjWuSzvxL5KgpAm8guWu+bSsN9b2c3NDTWLHR30L9uUK/6CjlV4wzlKTXJfZEuHjcDugrJA7AXyzQ62UR6PlKa6hOTTEw4sD7hPg/RIVtn0YwDu8bRdl7/7XQ0FJZu21G1mUzEpuv/ReQ2lpgE7OK37kQao1wBswm54bXQCqhMEVG0yTbOsEj3DpIK8bIjLpTcj64SDUyjSQnwFF4IFkEiIpIokpWbXZWCKcv1b42RXUhGUA
 6SxiUlwGUb3P3VuZk5510KvcL6hK8BhYUY8yJhw4AeMD1jrHgqcXuWByCm48az8ZHvRgr+aAmUKs+UIrU7MFCw6v6Q40sNIfrT6Hju53i5fezxVw43YWmdYMR2LA2ckA2OWaAB4shGHBUk4eTJ0ECWr0BdFmqgFwamrCoU5sKezIAUzT3pb60/5XChDPgzs0E/CVgiSbt0MAhRoQ+iXbYuzoAMz3sWzBGpdYONjSMD/kamNkXWvdNn337Hw4WodtzPyjVNhlVKj6008vEZz1zA6CgQSXWAravmoUCon+GQ7VLnFnZiw6wExee8OVa8VZZJGfzHhBRYKgCZmdD2FcC3RIqyhlVrmmE5ceJnsanCr3tCn9q18eZ6OqGPq5CLc1q+mNaM+6rk5s3lC7HDHhf7cxoe2+MOq9Nx+5CUi7aaSND5Qb1O11yQQuiumCDVkDtuBNJxbf9sfIgDI+tlVIw3EGbfVcOcwdCEjH4B4JnAPGshVjdc7u7WeyM6sU=

Hi Andrea,

On Sun, Oct 04, 2026 at 09:27:06AM +0200, Andrea Righi wrote:
> Tasks running under a BPF scheduler are currently invisible to NUMA balan=
cing:
> their address space is never scanned for hinting faults, so they never re=
cord
> NUMA fault statistics and never acquire a preferred node.

In case it's useful, I gave patches 1-3 a try on one of our KVM hosts,
backported to 6.18.54 and running our in-house sched_ext scheduler.

It's not exactly the series as posted: to avoid changing the scheduler,
the backport drops SCX_OPS_NUMA_BALANCING and drives the scan for all
sched_ext tasks under the sched_numa_balancing static key alone, and it
passes curr, as there is no donor there on 6.18. The fair.c parts are
the same.

As a controlled check, I used a stress-ng --vm worker touching 4G,
pinned to a CPU on node 0 and then moved to a CPU on node 1 with
taskset.

Without the patches, under the same scheduler, mm->numa_scan_seq stays
at 0, numa_preferred_nid stays at -1, numa_pte_updates in /proc/vmstat
doesn't move, and all 4G stay on node 0.

With the backport:

 - mm->numa_scan_seq advances (7 to 12 over two minutes);
 - numa_preferred_nid is 0 before the move and 1 about 20s after it;
 - the whole 4G (~1M pages) is migrated to node 1 within ~20s;
 - the task stays on the CPU it was pinned to.

On an otherwise idle host, the vCPU threads of a running guest now get
task_numa_work() calls as well. On a host running the same scheduler
without the patches, a kprobe on task_numa_work() sees no calls at all
in 30s, as task_tick_numa() is only reached from task_tick_fair().

Thanks for working on this,
Vladimir
