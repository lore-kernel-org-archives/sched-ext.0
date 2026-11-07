Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017719;
	b=rSpkklUQYvVV4HJpz2HMZaXLJhFaIwn14FfyoQ6kaqXkFcf5Cw1QbQXPBVGwC18aTqK7
	 z+E607L2MHPg5x6aRYW40zHsBxUyeKoIGHwWjXJBU0oNl1SMvEuWKPCiL+G1yGJSwGwYw
	 HrscXFuPTfiWw5X8ArE/hXjVNTD/lOCxUORapTgI1fouNRcV8jTn7vtrbLTZLIjFpIlqe
	 Sz3JFupBkbbDcgJYobTQ0QqWQWe4GRPgstWx9BiE+o+2Janjk3T0q2PWQ84dFjaeDN1Mx
	 8D7itrCPXRJz2SR4kfcUe027unK7cfmgHwULw+2MEAy15BNaPWedGA0KylzYYHmR51Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vkNpnDXn7v7FcqEceWtawbzUhjqzoj0bXsK40kYeEvM=;
	b=qej6Vv0AAdAPULgha2cHqnlPLwO5M8D32UChcY7z6umPTw4Jv3T7hnerP5/0on3kKx92
	 dzZeHTB4exkdjKv+ZCEx1WPWBWcCcLKWa3Q/UvmTCQ6sOV+Fj4k+iaNAMHo8tCr5pvgdF
	 1wAVlagG2jDLRPcZ7q3VjqYskvxINlmkmmpSnzyF+ZDCjqlKYuBRO4nchQfdqymzJNpsh
	 PMEQULvddgI7B5qzgm3o9sB91DbGbOFssyqq8/K6UY0xEAc9V417CQQe26foH4TVhf/pY
	 WKPiEhZy/BGnosDIWXS+v7K4qrcZ2WbnLbF4kmaWrr9CuvNh3hyvuTAm8kk3/+P6/Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eC7z3H55;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6CD606A333
	for <sched-ext@lists.linux.dev>; Sat,  7 Nov 2026 02:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F6CD606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eC7z3H55
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso11540735e9.1
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 18:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794017718; x=1794622518; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vkNpnDXn7v7FcqEceWtawbzUhjqzoj0bXsK40kYeEvM=;
        b=eC7z3H55cTeYPs6ivpspfn4FJ0LE5VwEaQuTrmAmVAVlpgEAjSaGNAAw/hIaYeSLzq
         17JOOQQEDSIZvey5APodoy2DV/wJImLHbLLsu91orh42ptYd1Z27y3tGy8KCcqiJhAoe
         RXmy8tC2fjRjHIdxMWUdWE8L9q/uGSeop5873m5BsVfKgP3FrWKwufoU6nJdVaZcw3nz
         2p76MNYS43RyMKhwl/7kGyBP+wu3rN2UijXVQ3RboPCUOQC3SjGxEGz3WBKEn04zO+nz
         /kr4OdisQLBZEvjg38+85S8PHxbNWzMhhFyTAvpST4EVugIggbXhbu+gqlA1VyvzbgR0
         +omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794017718; x=1794622518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vkNpnDXn7v7FcqEceWtawbzUhjqzoj0bXsK40kYeEvM=;
        b=KHyflzwKcjGSi9cFWNEwu5L+TwiPx9TOqVqncbjg7UIe5B/vEG9v7gxyeOL/q9BwFR
         sShqQgC78sUDq3428rJ5e0pwdqzVzclGPAEv47w7Aq9FsRzboSL7+osPxwxu8NV0gXBt
         clyQ1jyPqdd4GvzIK6Y6Q5YXLhpE+v0fbsMLACJ+NfSDtVLO8IhPvYEs3URczREZw1xX
         vrZqBg+EJrLtuu7tXRoAZl0Gvy5ZwkJKJfR389FBDSnk5Rpoz8rjT+D/FFs3ole6+vXh
         gGajiT9FkzBs6PFOTqCh7I8UQTXJa79BDCQ+eqkHmWXPwtPeyFveRTtbKPVQtw6U+jdq
         9Bnw==
X-Forwarded-Encrypted: i=1; AKwUvBz9SpTKvof83XljVE5uWGbOyKygMJezjga0JAug4hjwLhhl8w/vbUpFg8iCfKpcdE70ugnMaktjLPQ=@lists.linux.dev
X-Gm-Message-State: APuU4Z92o14NIbxP3VAuYnGyyp43MD9UMVtLHDeCT14T6PNIN5tJ2vzU
	71kmb3e5ur04nyADv19W5BEl+K8HULv0qc5TNpmc5KEXacVcw+qYZC5B
X-Gm-Gg: AYBFou2RsBhGXOoGPwpT9U61c6J5N55gZklM6QS/h9duqHGf70iTccATqaahdZsOzyH
	Cb2tejYoYpPEgimUEjcCE/iyHuEvrVYEx2+hFExjjRrB8SMl585n1HY2uqvsnBUjKkyIkjrySUn
	DG+tNNlCe9ZcIfv7BdX+4YVRxest636jVFWG6gHnNntKDevOYpg1CfCnte+0Z1w7X28IhiCtsQF
	sm3nWNIbKAMpuU+QO26qwPis/KbJWHrO8W5z8hsckVL91yR9/vUbGwNuHJuMExGsLlM1tJWNhta
	IyLQl4I7++I+N7sbdViwCD7Z+FXYff+2n3Ixt8jrf1hAwkz40FQJDyFTF7i+g+GsgDNFoJEkfkh
	OI975ZuTvK2gZ/cqOBQ2HS59lzwnz6QJ7OAvEg76o61Ouua1xdjWOrVdL15Vp67fDSqtib+XRCn
	3Rut6Z7GCYFErhXq31XSuSGgZiRRrIK7urkIRBOWYqhBfFsh0N+ifMiEkc93qzQnlUb9DjsR54y
	QG6laKX8FiI1Tv550klyE4/C7C2/o6dsz1pp9C91HwElVhwobRu/1zLavCxdfRTOXYqJCKqNtg5
	xvhRuP3xhHaDIJTu+BjRwWOpm7BI+SRIEaBCBlkLO0I/WSzXYRk/MHb1rY1V8Yvikus86TmvxQD
	dgg==
X-Received: by 2002:a05:600c:3495:b0:4a2:150f:1610 with SMTP id 5b1f17b1804b1-4b6dfba86f0mr71877255e9.23.1794017717990;
        Fri, 06 Nov 2026 18:15:17 -0800 (PST)
Received: from localhost.localdomain ([86.124.84.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5f11sm6367449f8f.49.2026.11.06.18.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:15:17 -0800 (PST)
From: Radu Toader <radu.m.toader@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: peterz@infradead.org,
	tj@kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] softirq: Treat an interrupted idle task as idle in tick_irq_exit()
Date: Sat,  7 Nov 2026 02:15:08 +0000
Message-ID: <20261107021509.968928-3-radu.m.toader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d8c4fb5ce3e465c9c9e562c851d586ef8e5cc43d85d61998f63f2c48d431778e@mail.kernel.org>
References: <20261106094343.174905-1-radu.m.toader@gmail.com> <20261106094343.174905-3-radu.m.toader@gmail.com> <d8c4fb5ce3e465c9c9e562c851d586ef8e5cc43d85d61998f63f2c48d431778e@mail.kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both points are right and both are changelog-only, as the report says.
Fixed in v2.

On the first: PF_IDLE is indeed set by cpu_startup_entry() and not by
init_idle(), which I checked - init_idle() sets PF_KTHREAD and
PF_NO_SETAFFINITY only. So the gates overlap rather than one containing
the other, and "strictly wider" is wrong. v2 drops it, names the state
that is no longer covered, and says why nothing is lost there:
TS_FLAG_INIDLE is only set inside do_idle(), so tick_nohz_irq_exit() had
nothing to do before cpu_startup_entry(), and nohz_full CPUs stay
covered by tick_nohz_full_cpu(cpu).

On the second: injected idle is now named among the newly covered
states, with play_idle_precise() cited and the reach beyond sched_ext
spelled out - intel_powerclamp and cpuidle_cooling via
drivers/powercap/idle_inject.c. Peter Zijlstra raised the same point and
has a reply of his own in the thread; the gap in the changelog was real
and is closed.

No code change in v2.

Disclosure: this reply was written by Claude Opus 5 (Claude Code) and
sent on my behalf, in the same session as the patch; the patch changelog
carries the same note.
