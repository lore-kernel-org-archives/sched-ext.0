Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C422ECD1D
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960450; cv=none; b=BA22rnykS+MMxN0laRbX4WAZcdcw6BR9c5b0RKYZDHtiVooqwT43gCftVKFJz5BlXOsIWy0ImryIYEQlnkboUkSMs+6fpY/QOwHuVnJ6Oj6dZim4zwpX+MzbztZoxrNPviAa2bnkye5LEwSkfQMJh+/NVah16bFQjq7/Ppe/NA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960450; c=relaxed/simple;
	bh=jSp4H5J/0nBDLiKcaYReTUODTHk/k7hqDNweqIBXfoA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ptno94dS5DiGUSN3JX7dcNDtYtS1NsdeLqsyrLC9E9mKyx2C2F6e2GUPG8nzIZ79FyR8Ae9jW3KH01QKdiYSfalqjTKRezlbwuoOtvv8zY/oLDiB9CqH3TjPaOy4iT6LemD6nzAuOhLZoxRgnOFr32jGpEEbIrxbQm8Bo/tijHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C70y18rg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C70y18rg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E861F000E9;
	Mon, 13 Jul 2026 16:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783960449;
	bh=+1Iryy6tGyj9x4TcZ1HUvAtvB4KPUZfTb5/bYWIXR3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C70y18rgJMNXeXUMTMDNUSlhkdYAyFFR+MJlRffTZxnNu1VzzoFZCQSQtLQB+5wgQ
	 IexEFmZv72rEYTfgjMfJYyBpOiDTIwpmi73bwMVDaEqvCugN7VNolJjrkj8Db6MDMC
	 uFdiR+8XG4P+8GsGvqlnm2V0IWzDm4DUTysXwUpfF1uzu9JUpeS8YeLZumSIXkYZXe
	 JUJvEs8heUiCnkIITIHNmbPulH+XZB/8y9oaCqnZbiP5sQ/EoMQ9H4AJC+MxrGBh9q
	 fql9dqOFQ4LSM4FAgCXdnClGRcwpWae0NpvW7hqQff0/Di0+H8XCHmqdm5ieNGqBqj
	 6kEGPDNqE85Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] sched_ext: Add selftest for blocked donor
 admission
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260713162112.26785-9-arighi@nvidia.com>
References: <20260713162112.26785-1-arighi@nvidia.com>
 <20260713162112.26785-9-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 16:34:08 +0000
Message-Id: <20260713163409.50E861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The selftest fails to verify strict CPU affinity of blocked dono=
rs during the same-CPU topology test due to a flawed conditional check.
--

--- Patch [8]: [PATCH 08/10] sched_ext: Add selftest for blocked donor admi=
ssion ---
commit 933cd9c1a4c089059db1cd4edea0c388cf1d4510
Author: Andrea Righi <arighi@nvidia.com>
Subject: sched_ext: Add selftest for blocked donor admission

This commit introduces a selftest for the SCX_OPS_ENQ_BLOCKED scheduler
interface, testing blocked-donor admission requests. It sets up a priority
inversion scenario using a custom BPF scheduler and a kernel module to
exercise proxy execution. The test evaluates both same-CPU and cross-CPU
topologies.

> diff --git a/tools/testing/selftests/sched_ext/enq_blocked.c b/tools/test=
ing/selftests/sched_ext/enq_blocked.c
> new file mode 100644
> index 0000000000000..4df9671222831
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/enq_blocked.c
[ ... ]
> +	if (status =3D=3D SCX_TEST_PASS) {
> +		if (enq_blocked && proxy_enabled && !nr_blocked) {
> +			SCX_ERR("ops.enqueue() did not receive the blocked donor");
> +			status =3D SCX_TEST_FAIL;
> +		} else if ((!enq_blocked || !proxy_enabled) && nr_blocked) {
> +			SCX_ERR("ops.enqueue() unexpectedly received %llu blocked donors",
> +				(unsigned long long)nr_blocked);
> +			status =3D SCX_TEST_FAIL;
> +		} else if (cross_cpu && nr_blocked_other_cpu) {

[Severity: Medium]
Should the unexpected CPU enqueue verification be restricted solely to the
cross-CPU topology test?=20

If cross_cpu is false in the same-CPU test configuration, this conditional
bypasses the check for nr_blocked_other_cpu. It seems this might silently
ignore a regression if a pinned proxy donor is somehow incorrectly migrated
and enqueued on an unexpected CPU during the same-CPU test.=20

Would it make sense to remove the cross_cpu condition here to ensure strict
CPU affinity is validated across both test configurations?

> +			SCX_ERR("Blocked donor had %llu enqueues on unexpected CPUs",
> +				(unsigned long long)nr_blocked_other_cpu);
> +			status =3D SCX_TEST_FAIL;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713162112.2678=
5-1-arighi@nvidia.com?part=3D8
