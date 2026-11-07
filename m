Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017715;
	b=angcg6PKx13njdMcapWLhWXnNfOslhFWBxyjXHGgJnjyFbpkn+aJQhekQgx1nzkMNlWc
	 rT+TuaB0UGP1tKTUXTTl56GOV1SnHjbrohFei5v/uApTOVABecw4lJ5gLAZ5zM6UMlBVn
	 GD/2Nr1Ba3Gx16sp/fuUwC26TYB9g3wZMRMIGPuzZJw4e0T6qP2ayFiTFz2zRtFJvFnxF
	 zwpKb3krgOxVRlKUUUleQa38R6Vq7YvMwlv6bp2DobQuD1UNF6Rx54hSOgaue83KvQygH
	 1F50JPYfSnrvIuJgriwjYdxupdjmDO4SuqXJE5T0Zrq+i4PrbZLafM+3651rbOkDISg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dc9ewNRLy/KDUCgVc1zw7V1amTwtToITL8ldPoKTuCM=;
	b=tR2n3tXP392jTNhU4c2iXLjcSN7OM1wKRebxKkoFFG9rFYwl03U92Llp38yzoFfvBkCw
	 QQlMGQY3yMwGuZ9DbobHyrHeqEb0zYllwSspv4aPocn5Y+XdqJtzCt21TopfXjmbKQlhM
	 xr8Ej/W3+0bYR76h1YGvnwLpbGNjuPcsyOF1MbNErtot16bUXG0bTG1TKCVQ2XqD00Iad
	 MhvhXOI04mGPbmg9B/yUAhLBPAx62g9rpXDTdJYPEiBd6OwV5gQTUjwLS2uLnp2Ke3mMR
	 UlxIRhHf6l1vk7XL9Y7Ypkorq9ZWDPMs1zLYZkAyhTAhh+SNlwv69BvbvEwDOv0yd1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OlMSxjvu;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82279606A336
	for <sched-ext@lists.linux.dev>; Sat,  7 Nov 2026 02:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82279606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OlMSxjvu
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e4831c028so1261205f8f.0
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 18:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794017714; x=1794622514; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dc9ewNRLy/KDUCgVc1zw7V1amTwtToITL8ldPoKTuCM=;
        b=OlMSxjvuVT8o727BnWxPQmIv5DCV0NeaWd36WhyZQV4CdITj9Spla23HfOX5TAdiPh
         u+D6S7UVmJjwVVSXchvyvyYwoHWpoIDi55ua9FpGtqT1UxaCDkC4YKNS6YW5PCvkt9V3
         uX6Z3FBn2dO2mM3uo6bRx4pKsDRnPT5Est6doCTUm1jAqLY/eHwmv0XWQNJXg6icdLdX
         nPcyQXqDS7EwNV2Pz1s6AZSA7CUM+s8uurzMQwmB17IsTT4Uh8PVqqpwwvCl+KyIERAX
         /l+InJ72S2gZMhUTFf6t2esYg7EMuzcG5KicoO4QUT7I6MMCz8/tMWjwQWjLTd9pAMuG
         aqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794017714; x=1794622514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dc9ewNRLy/KDUCgVc1zw7V1amTwtToITL8ldPoKTuCM=;
        b=Op+zipy3ONobz90MU8NEhxJUXxThxsgmuji++1a2qNEoKKiP+bKxrKSXT8XGA+g9jm
         sb0rAS+Dr+dAsN0aEe9jjnebbDrSnIYOHq9wcn+q3++ZLfF/MbRE7w6uyOHEVj9WM7Kk
         opmmN4K2xAQqUQpTdrkz3n+fWVdWaCO3SqGtWtQw7dTbEB6gX91Oml3XSovc5xx8OMA/
         ID2km2O83ENxEtr43nL4SGxcu6M57WS2xWSubyQcwEAQQEj+ofZJwhT2XU4FovuMgmOp
         Zb5Mx2YRzUUhQOPzaBSFVeAaEaWWV+MLxPjhS2M03BU6vC4q4RawkSGqipXAaoO1CjH5
         IoOw==
X-Forwarded-Encrypted: i=1; AL+hErHshEoSeya+rPCjK3/OJ3Y3Vlb2wCtFn6LEDdbfoqordZyKOwcKUY1U9QspzUy7exthw7oemsG+J/U=@lists.linux.dev
X-Gm-Message-State: APuU4Z/6up/gWBntc4/sM5krXo9d6pW+n0TjZtZJxEjONXuPCG4HkZfz
	sOJ31wEzETsXlA/1oUbC2PJcfapJpv4WAhlz+pn4UNlZpW2hwUzrnZkP
X-Gm-Gg: AYBFou2ERbZeKWsFi1ncckbedt2us/0B+eDw3TlHvL1kFOlUKgGzEz+I3rTtjacNKiC
	H5ZBhsxeYrgMpp6KwJGGAbsg7IPPtAInl2biMKF3FMy29y2eMGuhMAzFPJ7pg0EdE9D93ecCiIL
	BXq6h5QOSgPqHaXJvgF2pn244rEpSvoB7RbCRSDbOckRndaV5PoP6DADTpY8Lqdzic5GV+L6zRp
	b7hEr62S5EQjRKbgsJm3bsvwB77R5YhADprxrAuUHr/LNzFrah6B9vwrqeJK1jy7VF+lgr5bwsi
	vyaLisAsjxxSNlnzlM5NBLC90xfyvNpWFuK7Bertl8PsaG1Fks5w8oPbUoi7t/nr+m62ot25fIY
	DHj/F8hz5f9hgAwGJy3tcZof87T7Vy5NOGj+j99Hxr/vPjYmlanP6p57hRO5PBbIf4pgV+jiNTC
	gbmWrU7fPsJseFziep7B6kJvyVX0PU/UkzipFyunWbWgrbAG77anI5YUTVlJzVnZKgazL/BqGj+
	GqOd1HgX/pMAshbG3o7adJWf0JbPwItYuSy12AgXtPorqEpLrGFWB4Zssho2tN0LMRmChEOqk1j
	EraK6lxNwuyMC94SYNMjAl8QcBHiEyiKVAX6CGOqWZvq6bvnrZCmhXJn2gyfDpL1gLjty7xPfy9
	KOVAjcjyLkSSMufS9rjVWejk=
X-Received: by 2002:a05:6000:41c3:b0:48b:108:48cf with SMTP id ffacd0b85a97d-49275b1bcfamr7936541f8f.25.1794017713547;
        Fri, 06 Nov 2026 18:15:13 -0800 (PST)
Received: from localhost.localdomain ([86.124.84.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5f11sm6367449f8f.49.2026.11.06.18.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:15:13 -0800 (PST)
From: Radu Toader <radu.m.toader@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: peterz@infradead.org,
	mingo@redhat.com,
	tglx@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add scx_tickbug, a scheduler that holds a task on an idle CPU
Date: Sat,  7 Nov 2026 02:15:06 +0000
Message-ID: <20261107021509.968928-1-radu.m.toader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <au4HhnJoKvJ6GPJT@slm.duckdns.org>
References: <20261106094343.174905-1-radu.m.toader@gmail.com> <20261106094343.174905-2-radu.m.toader@gmail.com> <au4HhnJoKvJ6GPJT@slm.duckdns.org>
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

On Fri, Nov 06, 2026 at 06:59:50AM -1000, Tejun Heo wrote:
> Thanks for catching the bug. However, this scheduler is more of an one-off
> debug code and I'm not sure we want to carry this in tree. Maybe put it in a
> github gist or sth and point to it from the fix patch?

Fair enough. v2 is the one-line fix on its own.

Rather than a gist, the fix points at the v1 posting of this patch in
the archive, so the link cannot rot and needs no account:

  https://lore.kernel.org/lkml/20261106094343.174905-2-radu.m.toader@gmail.com/

One offer before I drop it entirely. tools/testing/selftests/sched_ext
already carries nohz_tick, which asserts that a finite-slice EXT task
restarts the scheduler tick after an idle interval on a NOHZ_FULL CPU.
The condition this scheduler holds could be asserted there as a selftest
instead of carried as an example scheduler in tools/sched_ext. If a
regression guard for this is worth having I will post it separately; if
not, the archive link is enough and I will leave it alone.

Either way, the reproducer turned out to have a bug of its own, which
the CI review found on the same posting: an untagged task pinned to the
target CPU starved in the shared DSQ, because the target CPU stops
consuming that DSQ while it is holding something and no other CPU may
take a task pinned there. With two tagged tasks handing off it could sit
until the watchdog unloaded the scheduler, which contradicts the "the
machine stays usable" claim in the commit message. Dispatching anything
with nr_cpus_allowed == 1 to its local DSQ fixes it. Noting it here in
case someone takes the thing out of the archive.

Thanks for the quick look.

Disclosure: this reply was written by Claude Opus 5 (Claude Code) and
sent on my behalf, in the same session as the patch; the patch changelog
carries the same note.
