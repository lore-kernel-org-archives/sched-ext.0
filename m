Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2F051C33E
	for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699285; cv=none; b=LN7WKIuSX1tvl7qdnw9V2urZPszHxQubVV4O6SGhUCkXTnwsfWD4MyAyr+l07iZEzPT8qtbTtMnZ8hcLiHBidPgMy2SqqoCZUf5pedzTG9NF7J5ixW/zgnG9TKTacmXEThniVk/FXw7ddaElCQR+CsR00aHIpmU4TWMUVhIVwIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699285; c=relaxed/simple;
	bh=90YWAERfQDCwaBojwRXxy+cNkn+HfHFUKmHiLMAGUYg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=flrs88hgMcs39cqHRU/ilNSoj0emRcMHM6m2Q76pBcEcvLlx2sPO7DiT16wawdXAhwcdwUhbHmoLkJM+pRKomQIv4oSFEVByuycdlfotg/toc8oXdxKnqS6UsfN2+viRS7UI1X8rKk6Dv58ZSAxjEC+Kly2b2vMsidsaTS8iBWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9CoKc1H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9CoKc1H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33D01F000FF;
	Tue, 29 Sep 2026 16:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790699283;
	bh=7e2etYvGHSCU0DFCgxpLYouAY5v2p0oZJZfsqGeK0Jg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R9CoKc1Hvsz/vEpm7oeVLjDy1LJ5POFayTWuJLoGtHOCTjGIBcOYDl2l2n1pkjIIh
	 0ZrM7f19h3jiCfNKW7iSnkHSuwhsuhCdhAyDZB/dwyZBIsoM15scNrt/A+jiURGQPy
	 T7R8sXPJTkpazQOjZx3afhtOwMZICfqBMoFVrs0fUM18BRV+QMBlLo0RA1NFJJoxuV
	 t7tzFt0h2g6aDc0OIeUWJ0LC8/rbrfKI2K7D4xIQ2cTFsj/YDG5H5AWgVEuRz5zxLH
	 1X+d3Sdz0fKebk2DJHCzDoH5PuvqUrJGFH2BXFKY6czmUfgvP0RossoOWvE1UgMsA0
	 lYPxamSExN9lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] selftests/sched_ext: Add a test for ops.dequeue()
 on remote local DSQ moves
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuba Piecuch" <jpiecuch@google.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260929161730.185271-2-jpiecuch@google.com>
References: <20260929161730.185271-1-jpiecuch@google.com>
 <20260929161730.185271-2-jpiecuch@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 16:28:03 +0000
Message-Id: <20260929162803.B33D01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/sched_ext: leaked bpf_link FD on error path blocks sub=
sequent tests
--

commit 1ccbec9969985b2fbfb40e59807388cd3896b3e6
Author: Kuba Piecuch <jpiecuch@google.com>
Subject: selftests/sched_ext: Add a test for ops.dequeue() on remote local =
DSQ moves

When a BPF scheduler moves a task that is in its custody to the local DSQ
of a CPU other than the one whose rq the task is on, sched_ext migrates the
task with move_remote_task_to_local_dsq(). The task leaves the BPF
scheduler's custody when it is inserted into the destination local DSQ and
ops.dequeue() should be called at that point, just like for same-rq
dispatches.

> diff --git a/tools/testing/selftests/sched_ext/dequeue_remote.c b/tools/t=
esting/selftests/sched_ext/dequeue_remote.c
> new file mode 100644
> index 0000000000000..ab42ac694ac6b
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/dequeue_remote.c
[ ... ]
> +static enum scx_test_status run_scenario(struct dequeue_remote *skel,
> +					 bool use_move_to_local,
> +					 const char *name)
> +{
> +	struct bpf_link *link;
> +	pid_t pids[MAX_WORKERS];
> +	int nr_workers, i, status;
> +	u64 enq, deq, dsp_deq, chg_deq, remote_dsp, remote_run;
[ ... ]
> +	link =3D bpf_map__attach_struct_ops(skel->maps.dequeue_remote_ops);
> +	SCX_FAIL_IF(!link, "Failed to attach struct_ops for %s", name);
> +
> +	fflush(stdout);
> +	fflush(stderr);
> +
> +	for (i =3D 0; i < nr_workers; i++) {
> +		pids[i] =3D fork();
> +		SCX_FAIL_IF(pids[i] < 0, "Failed to fork worker %d", i);

[Severity: Medium]
If fork() fails here, SCX_FAIL_IF() will return immediately. Does this leak
the bpf_link in the runner process?

Since link is stored in a local variable, it won't be freed by the test
framework's cleanup() callback. If leaked, this would leave the scheduler
attached, causing subsequent tests to fail with -EBUSY because only one
sched_ext scheduler can be active at a time.

> +		if (pids[i] =3D=3D 0)
> +			worker_fn(i);
> +	}
> +
> +	for (i =3D 0; i < nr_workers; i++) {
> +		SCX_FAIL_IF(waitpid(pids[i], &status, 0) !=3D pids[i],
> +			    "Failed to wait for worker %d", i);
> +		SCX_FAIL_IF(status !=3D 0, "Worker %d exited with status %d", i, statu=
s);

[Severity: Medium]
Similarly, if waitpid() fails or a worker exits with a non-zero status, the
early return will skip bpf_link__destroy(link).

Could the test be updated to use a goto cleanup path, or perhaps assign the
link to the skeleton so it is destroyed automatically, ensuring it doesn't
block subsequent tests on error?

> +	}
> +
> +	bpf_link__destroy(link);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929161730.1852=
71-1-jpiecuch@google.com?part=3D1
