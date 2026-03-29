Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF822EB859
	for <sched-ext@lists.linux.dev>; Sun, 29 Mar 2026 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774775191; cv=none; b=FBa1ydh38uuOqYVQFUC8CRxL3/x1wagGI6e2nNgGVq5Xl2T+Tup6oN+WkH7llMpyu70V4LSHmKsIf4b8sY01/GV2aMW4ah0s8uGpcJADVqY891W1bwYzBFtFXj6rpurGo5KxtGTPmz8Iw4PL4MdAcEsCEE0bmbDTxysf/ekFOuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774775191; c=relaxed/simple;
	bh=6zXpS7WrAu8Icz1qOD/H6Hd7Hv5lW5/T6Ir7LbirGm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYJ0ue7j0KIgh6Po/MS8ha1mmjpxFoo3tZ+j1bcsoyaS59tUsHdr9yxkbL3gsHcOqjpN5zoU91arKHxPweh7VJ72ZunzSP1Z8wx/TLDApPdwiLiLyUf/oLTze9QPVbqNdjlm/BdFjnk7yEHV4fzHln/AhQqsEPXO7hBCrC/hBlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3XKdPro; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3XKdPro"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so239580a91.2
        for <sched-ext@lists.linux.dev>; Sun, 29 Mar 2026 02:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774775185; x=1775379985; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VpXBbr3gzUEIbQHockJ+bH9IWsxetOlf19QXQSzPhM=;
        b=J3XKdProrS8CqGv7L+L3SrlhMyu68pu4JswFPF+TWmw6wFSQKYDvmvlw8Vk+y9EUGS
         ri5/YX3FNAec0JqdPhV0ySUhVph5I+YOtum1tTAzEOV5TBL3QOiwjoYKAOZQ4PKqmNZX
         1oHvzNbp2OZ6ES8H8fUhpjWwvI814GIIp81/9uqXyqvTVhjstvebL8LVHXiYYvLWn011
         SQB/peK/GlODK/KvD1/TdHpdyJbqn5gELe0kii/iEd6eSeenuklx/nYEW45hZ7FyIgMo
         IxShqOSaBMccZizMRBxQNhW1YBDSBuodxhpBDymfQpX/rmOZ3sVlpaH4W34RW8xKlYgo
         d4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774775185; x=1775379985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VpXBbr3gzUEIbQHockJ+bH9IWsxetOlf19QXQSzPhM=;
        b=G87Rv/g0BdjZiUai4mYABx2aQbWH5RIZUefN0+RtF4gWoWeUNlPEQHMQI4ThftLb6Q
         nMGpGSBRa2fB0OnJEJohZscx2s7nQ3fhV9unLElj4M0H/Ix61sPk2lRKbGVzTL4zL35q
         D4gDIVIeL/7CW5mfMGCozIJzr7XyFmc4DgpG70ilAlZOpZQLxUfaHbzIvxJYJEmSfQqt
         QrvRWqSofo+q7gsYJvIDDT4vVsRXBGFovm9PFxaNYEZuUlX4keRnnG+49xSDz09XHNXp
         UjiF/noe+ko1fSpRuftGTpxAjl4lZ3qeS9+DnqFxfKzsVxtdwS8ZrL5be3UQbXR+EngT
         IuUw==
X-Forwarded-Encrypted: i=1; AJvYcCWoS/F24x/DrANdw9xJLjmXfwbRSj9vsYDl78rfkaMTefR/teYwPtTHc59/gPVwdZPz6824YMrp5rg=@lists.linux.dev
X-Gm-Message-State: AOJu0YxxH2ZnMmRsOpfgjMRBwEGMeLfiVQnmMUb6gEerWW/o5ZfckUAv
	NOsyULqL1GSXfn2WEvh5pj7QU5ECYGwlwMoXdGiA6m4F27vybepb7Zdo
X-Gm-Gg: ATEYQzzcNTkBUv9fiq4ieOXx7dD2Rwmf8f0WtqAO73vbkcZDEW7UOEDFRQpz4mrgGf5
	Bfill7PGlPVSv8IF795NICetw0QPS4g7xkr6FnmckPCt3R6kgzxkcacITQscG0imxH3748B5JkZ
	0SQ407/bHTBKvwsr0EHiq6TLgMlc+c9hNYnthATefbjdLWmc1qGnQN/+MhicMygZN0yFtKk1dIe
	y7SHVkY6fzdL+q8GQ8bxZbYZQzl6Ewv2LgLoKm6fdNEd45u4uxCbPnTvdVR99oOylSIFbh3fKkZ
	xAE2E7dy3ZuRuACpbFzWAg+Fe667fRssFe6w9L4BWIfFoytVvwk+8fHMPAn7SSWTLQg7Dgy63lQ
	j1wPdI9g9jzCqJx2hW2ASB3ZsMyeSRaq6GsO53VJwm0MzJSfJFCwTJkFDZoJnfrCiBnQ9iK9kN+
	RQL+Ol0ntwzMvPf9hRuNlrnr5iRyk7vIXO+R+OaHhlnTkVKu8Lpj38mjE3RrxL
X-Received: by 2002:a17:90b:3c10:b0:359:8d0d:5905 with SMTP id 98e67ed59e1d1-35c2fff1fa6mr8090518a91.9.1774775184500;
        Sun, 29 Mar 2026 02:06:24 -0700 (PDT)
Received: from eric-acer (36-225-76-102.dynamic-ip.hinet.net. [36.225.76.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d94d33497sm3982098a91.7.2026.03.29.02.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 02:06:23 -0700 (PDT)
Date: Sun, 29 Mar 2026 17:06:20 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Christian Loehle <christian.loehle@arm.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add cyclic SCX_KICK_WAIT stress
 test
Message-ID: <r36q4trzw267surx5xbod3ilm4wgmmyurqk6kres6gmtj7qbfl@lyasdc3a2zlk>
References: <20260329001856.835643-1-tj@kernel.org>
 <20260329001856.835643-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h4pl7b6os4ckbacb"
Content-Disposition: inline
In-Reply-To: <20260329001856.835643-3-tj@kernel.org>


--h4pl7b6os4ckbacb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tejun,

On Sat, Mar 28, 2026 at 02:18:56PM -1000, Tejun Heo wrote:
> Add a test that creates a 3-CPU kick_wait cycle (A->B->C->A). A BPF
> scheduler kicks the next CPU in the ring with SCX_KICK_WAIT on every
> enqueue while userspace workers generate continuous scheduling churn via
> sched_yield(). Without the preceding fix, this hangs the machine within seconds.

I think it would be better to skip this test on older, unpatched kernels.
Sometimes I use my local kernel for testing before the stable patches are
fully integrated, so skipping the test would be a safer approach.

Otherwise, this test can stall the machine and make it impossible to
exit the test runner.

Log:

$ sudo ./runner -t cyclic_kick_wait # on v6.14
===== START =====
TEST: cyclic_kick_wait
DESCRIPTION: Verify SCX_KICK_WAIT forward progress under a 3-CPU wait cycle
OUTPUT:
libbpf: struct_ops cyclic_kick_wait_ops: member cgroup_set_bandwidth not found in kernel, skipping it as it's set to zero
libbpf: struct_ops cyclic_kick_wait_ops: member cgroup_set_idle not found in kernel, skipping it as it's set to zero
libbpf: struct_ops cyclic_kick_wait_ops: member priv not found in kernel, skipping it as it's set to zero
ERR: cyclic_kick_wait.c:169
Failed to join worker thread 0 (-110)

Thanks,
Cheng-Yang


--h4pl7b6os4ckbacb
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="fix.patch"

From 6f09d2298e547aa7a519d4bff262fc6851a969ea Mon Sep 17 00:00:00 2001
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
Date: Sun, 29 Mar 2026 16:07:05 +0800
Subject: [PATCH] selftests/sched_ext: Skip cyclic_kick_wait on kernels without
 deadlock fix

The cyclic_kick_wait test triggers a deadlock on kernels lacking the
SCX_KICK_WAIT fix, causing the machine to hang or worker threads to
timeout (-110).

Use __COMPAT_struct_has_field() to probe vmlinux BTF for
rq_scx.kick_sync_pending, a field introduced by the SCX_KICK_WAIT
deadlock fix. Skip the test on older kernels that lack the fix rather
than hanging the machine.

Example failure on unpatched kernels:
  ERR: cyclic_kick_wait.c:169
  Failed to join worker thread 0 (-110)

Fixes: e9b990b76922 ("selftests/sched_ext: Add cyclic SCX_KICK_WAIT stress test")
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/testing/selftests/sched_ext/cyclic_kick_wait.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/sched_ext/cyclic_kick_wait.c b/tools/testing/selftests/sched_ext/cyclic_kick_wait.c
index c2e5aa9de715..b060ffe63ba3 100644
--- a/tools/testing/selftests/sched_ext/cyclic_kick_wait.c
+++ b/tools/testing/selftests/sched_ext/cyclic_kick_wait.c
@@ -88,6 +88,11 @@ static enum scx_test_status setup(void **ctx)
 {
 	struct cyclic_kick_wait *skel;
 
+	if (!__COMPAT_struct_has_field("rq_scx", "kick_sync_pending")) {
+		fprintf(stderr, "Skipping test: kernel lacks SCX_KICK_WAIT deadlock fix\n");
+		return SCX_TEST_SKIP;
+	}
+
 	skel = cyclic_kick_wait__open();
 	SCX_FAIL_IF(!skel, "Failed to open skel");
 	SCX_ENUM_INIT(skel);
-- 
2.43.0


--h4pl7b6os4ckbacb--
