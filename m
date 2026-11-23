Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455187;
	b=46qEOxzp/X+YnX1B8+ACKGKQ9JIgvggWJ/QlfY2ldH43GusUNuq1bN7dOrxYH7Wba5iq
	 HGQ/zRcuOeQhYcmo6nWqqEZjlpcRf8tk5OOH42TMzdB00I7BZq9f25aoRm9ZXvUe+IQH0
	 KCWTOOY5Va6QyKn/hx+LXi5lu2dM4d+53KMt3a+36WtmQ7fqybpf/DOHXCF3RRM9HnoxO
	 FbaYv+2lOC444H7Dr2f9X7gKTwqhhLTCJ7yk3oiXyxhJyam/kv9W/SvDz0N5ht6Me9VqI
	 O/nWhXhXaiZSSWWQUFgM5+ezW09+8WbHakSLqqbm06ya33u3eIsLiCfRcle7ZgDC7pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455187;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0deV9ObnVPI/SV+jSOzuiMw8Uabo7T3HFvTJ3uK1vHQ=;
	b=4td7YCHIZmcuvESFPJv5P2vMfXQJYOv6V8IqZE+hi+moOQ1HMgKeLIpUOjmTtu7cS5Jp
	 tdppQ3ZGBVYB5/pVRcSR+MTiPEwozoFuMSq2ptisNSJXDjPVX1Sqq1y7/TMIHOE+8A2tL
	 vEWAf2HKfnYnbsc/KxpP2s1Of6QgcvsnJItW/FOdrr6SX7F1bBCW0xQhJnZWkfOMVR3Qg
	 OvC9dXednAXKeA0DhtV3bFgRgmjqNwQbRbr2k/cZo3XEOMA29qDhDPXUDfjJM55X93Yfg
	 Te8ShKpuGrmKAjCvJo6djkUc4eZPqJwdjagxOT0zp42+TP8oIxa4moK2wm+9pY0p+8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTcd8w08;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A25606A68F
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTcd8w08
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEF11F000D2;
	Mon, 23 Nov 2026 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795455186;
	bh=0deV9ObnVPI/SV+jSOzuiMw8Uabo7T3HFvTJ3uK1vHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fTcd8w08Qub2XwtXTVjJbj64KjiQVc+KsnqRnFT9+mS/UjMuYXH4F1ATpRbHg4oqN
	 rI0okWEFnrfmY5aJYchPNjzDG/T2b7Z6uvy8u2TFZK1kdNRgrT9lBHFMUivxeaNJAe
	 0TmRQB+GyHYwNnKmwffrhhizRPaScMxpUPVYi3V6oUo2anF/ydJf3n++7DPB/8d6O6
	 otLwNULFbgo7j3PZ5ZgqgMnmWR5ujoqa0LaqhuObN7jYEPVud9RTvbtnTWafx6QJrY
	 UehPv55nJTHqx+KwTFlJHGv1BSEBXd1ks1TYR3FdE77URAgpbVq296/TuR+T+FruWN
	 wjFu7xLouifrg==
Message-ID: <sashiko-outbox-229763@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 2/2] selftests/sched_ext: Test
 SCX_ENQ_CPU_SELECTED with queued wakeups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuba Piecuch" <jpiecuch@google.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261123171637.3859594-3-jpiecuch@google.com>
References: <20261123171637.3859594-1-jpiecuch@google.com>
 <20261123171637.3859594-3-jpiecuch@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 17:33:06 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] selftests/sched_ext: pipe fd leak on error paths in spawn_pair()
- [Low] selftests/sched_ext: missing skeleton cleanup on load failure in
  setup()
--

commit 53693d287118813912c899a1ad2d7a5cd66987f6
Author: Kuba Piecuch <jpiecuch@google.com>

selftests/sched_ext: Test SCX_ENQ_CPU_SELECTED with queued wakeups

This commit adds a sched_ext selftest verifying that SCX_ENQ_CPU_SELECTED
is set on wakeup ops.enqueue() calls if and only if ops.select_cpu() ran
for that wakeup, including queued wakeups.

> diff --git a/tools/testing/selftests/sched_ext/enq_cpu_selected.c b/tools=
/testing/selftests/sched_ext/enq_cpu_selected.c
> new file mode 100644
> index 0000000000000..674c855530ed5
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/enq_cpu_selected.c
> @@ -0,0 +1,194 @@

[ ... ]

> +static enum scx_test_status setup(void **ctx)
> +{
> +	struct enq_cpu_selected *skel;
> +
> +	nr_pairs =3D setup_masks();
> +	SCX_FAIL_IF(nr_pairs < 0, "Failed to get CPU affinity");
> +	if (!nr_pairs) {
> +		fprintf(stderr, "Needs at least %d CPUs, skipping\n",
> +			2 * CPUS_PER_TASK);
> +		return SCX_TEST_SKIP;
> +	}
> +
> +	skel =3D enq_cpu_selected__open();
> +	SCX_FAIL_IF(!skel, "Failed to open");
> +	SCX_ENUM_INIT(skel);
> +	SCX_FAIL_IF(enq_cpu_selected__load(skel), "Failed to load skel");

[Severity: Low]
Does this leak skel when enq_cpu_selected__load() fails?  run_test() skips
test->cleanup() whenever test->setup() does not return SCX_TEST_PASS, so
the opened skeleton stays allocated across subsequent tests in the runner
process.

[ ... ]

> +static int spawn_pair(pid_t *pids, const cpu_set_t *pair_masks)
> +{
> +	int a2b[2], b2a[2];
> +
> +	if (pipe(a2b) || pipe(b2a))
> +		return -errno;
> +
> +	pids[0] =3D fork();
> +	if (pids[0] < 0)
> +		return -errno;
> +	if (!pids[0])
> +		pingpong(b2a[0], a2b[1], true, &pair_masks[0]);
> +
> +	pids[1] =3D fork();
> +	if (pids[1] < 0)
> +		return -errno;

[Severity: Low]
Can these error paths leak the a2b and b2a pipe file descriptors?  If
pipe(b2a) fails, a2b[0..1] remain open, and if either fork() fails, all
four descriptors remain open in the multi-test runner process.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123171637.3859=
594-1-jpiecuch@google.com?part=3D2
