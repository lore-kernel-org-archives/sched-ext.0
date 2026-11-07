Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017718;
	b=iy5PQih1lfcnC4/UuIs7FDlaznTjFJFUHmY7fRyr0Rj06ZHGG6rUm9TJB6zfGHMBIesh
	 nM8eTpc3QjET3I3OssjcB2eYHcx9YWFd19YhKZQqEr8wUDEhPeB5APWqzUA0B0NJ0X4hh
	 6s5mEOXeUR9yYtlcPCxzFdMRe6+mSiofnFN8auK/asNY2SoUEO/ncgeQr1XmZ6hVGN9UE
	 Ulx9Gg82GsOU862fMDgWgh5B61F37a81GahFt8hlxZlDV0rzbHDtgN1fX90xbKgbDlwRG
	 sMzZT6Mkr0/wLCGmgqrilFz0tc9hqeqwoT/TsqVVaa8aQdvuuYGhHoLSfCb6u+ecgog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wikFKZw4t4TcuII1gnI7d31HqgOIm3ag7690hAeyUhA=;
	b=uJfXOaCyt3Wb4Ua3SvTKZtv0WPz2DViRXPhrIk7p6fiAWeEljExKAlCIjBrDu9foQ22L
	 jBbrT7sapNB9FBxufPv9t72mCeElEE2NCtMi+soEt2mMpKiGtoHjCGGD+BscyxTm9rycx
	 CZNYMYX93s5zUIZm60J7JkBCnnnTnMpIIe3m7/fBy0JO39NAXIuNhfvAIg/wCTtSFPnj1
	 hhckoKmQmVnfji9JyzGMeSlYtwSXE/NuH5dY/07nziLz9wiJtHSHYDbHp4vOXrpWjBNVy
	 g0wUE6/MJh5Gs806gTIYoo7wfEyZCTg7I2MVeqLPC4GmlyvWhw2l7/YZrn1fwOIvs2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZH13vwMk;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC9C606D802
	for <sched-ext@lists.linux.dev>; Sat,  7 Nov 2026 02:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DC9C606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZH13vwMk
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so12893885e9.2
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 18:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794017716; x=1794622516; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wikFKZw4t4TcuII1gnI7d31HqgOIm3ag7690hAeyUhA=;
        b=ZH13vwMk4pbqpkLNG7JlkIKwFXfNj8OngPc8qdZ+cGoTtehZFfNP5HLOZXIcv+6x0D
         JEnkW+u1Aux7Ki7VGjpUIuwappSVW7iPFYHWj5wd/dIEzlzhUjaB4TPJ1BJtCb/O+jFm
         8ZRTpiaSbqsQitL19DCetO85YW4YIxdVHT5Vr+B74IUE2q53UxMJKq2PdR8R7L4BwTfH
         ESEd7Acf2WqoDodYHytIO9u3iijoR4y04gR9cf5otPVKu/UT1PdfouUD86V4wjxMikRX
         tsQVZJT9PbiN1pyWjxPl74me94ghLFTs9Q6e1Xz/n4Vc82UU0Pe5s9v8sXyEaLZab8od
         vZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794017716; x=1794622516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wikFKZw4t4TcuII1gnI7d31HqgOIm3ag7690hAeyUhA=;
        b=bXupbHOI7U+ueDdRL28fh90AuVCRLnyITlfpw/hPlk+IFkXBgAMJLN9np6b36SqR3P
         2i6CLL9se+LPu/Dr7LYUMupOCQrJPZ0E+O9sK4sSM5RtFnrbBmepqdWFqwUpXzWqooKa
         gXYXB1KwrFniTmnMvty5ZvH38YvERJMtE4tdGbufTnnISQojWAamoE3enL+nzHJXpY3H
         vM/K3HiOlyF4Na11XJgj9dAGxnWTcf2QvYeVuUV8AMHXcCFKhRoWlP9bx9udGXnJ5NRu
         ahwnE+TwBsqCuoBJyVswmkfV5sEV0VKJVYpN0PI5TA2a0poBfRnci7PZnaKMEyvG8Fos
         tivA==
X-Forwarded-Encrypted: i=1; AKwUvByqZVL9kaUH3JQ5nWUjIMcnc9jiaYPDLP/RZNtwg4f0RFnN6ofYmf6F5vGhK079W3w15HQlefsHCWw=@lists.linux.dev
X-Gm-Message-State: APuU4Z8Jzk7yZkK2jtJJhiAYcb8qeu0girwYCOsPy+9cbH+UGddNpvtS
	EIIbk1IqSpCE8O5z3bqwh9/pwGkHFdD7vsWeBgrLJxx3Jbfz2hT34wOu
X-Gm-Gg: AYBFou0N3KRQdlZBcUHahDkJfnxGOxWTW83I+hlipngjrJo85SLcXwTMSjIh5FHLaYz
	SJT6rOX9A6tUbpZcIVjuU6FpdQw5aBwswbJdtb/aeQWRbqaaeExXRqSBus3ua/58JpL/61m1yKP
	MYhBLbeND0tzTuqHyyUkusw1D4h034z0bdwpaE+6fSkF5jQrVKSwd8EwOSiVe/sCYSmnDztiLv4
	eqk6bzEhgNi9paUZj0y+YpwQMRnwBOrj+GR1euFrx7Z/flPH6IIlKFo1T40woIQr9X7d/Vz4jYt
	s74tuA/1vpoR34ii7lV9cH+yu1M9yqnE0goqeDw/FxNSMWG79cbtkuiaGTSlWYn8Onlt8TIn9D9
	x78nbVkirIeJKbGVz/cdsJY2oU5vbpR+TBZN7DhGJ3XGAa+IEUOJc3WjutHrzjELyJWfmj9+JkM
	CJomieSuppI6cNAcZz1/6Df79cf654qSGEgks2CuVGfovb2ri3jVYoB59ME8jsLoMiEXzHS4zvZ
	iChTYAvhDUQexJT0qh8/tc69Yf7hR4cEOrzeKcYayYeNMct3bn0YjWZroKPyE7iqlN1CM5Z5c6+
	n9VxuegRGE/LvgSQV0p1NXuiQNzZJvLk1Z2eqgRxgJFNkun8EpQEhedb8T3Tt/JnHGGnE13R87T
	hxA==
X-Received: by 2002:a05:600c:4e8e:b0:4a1:f377:5c68 with SMTP id 5b1f17b1804b1-4b6e054a25cmr71898355e9.34.1794017716295;
        Fri, 06 Nov 2026 18:15:16 -0800 (PST)
Received: from localhost.localdomain ([86.124.84.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5f11sm6367449f8f.49.2026.11.06.18.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:15:15 -0800 (PST)
From: Radu Toader <radu.m.toader@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com,
	tj@kernel.org,
	tglx@kernel.org,
	frederic@kernel.org,
	anna-maria@linutronix.de,
	bigeasy@linutronix.de,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] softirq: Treat an interrupted idle task as idle in tick_irq_exit()
Date: Sat,  7 Nov 2026 02:15:07 +0000
Message-ID: <20261107021509.968928-2-radu.m.toader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106102315.GT1813469@noisy.programming.kicks-ass.net>
References: <20261106094343.174905-1-radu.m.toader@gmail.com> <20261106094343.174905-3-radu.m.toader@gmail.com> <20261106102315.GT1813469@noisy.programming.kicks-ass.net>
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

On Fri, Nov 06, 2026 at 11:23:15AM +0100, Peter Zijlstra wrote:
> So is_idle_task() is also true for idle-injection tasks. I *think* that
> is also right in this case, but it wasn't mentioned.
>
> That is, we can have tasks that are not rq->idle for which
> is_idle_task()/PF_IDLE is true, those tasks will also 'run' an idle
> state, see play_idle_precise() and its users.

You are right on both counts, and it should have been mentioned. v2
names it.

I agree it is also right here, for the same reason the idle task needs
it: during injection the CPU does run an idle state. play_idle_precise()
sets PF_IDLE and loops on do_idle(), so TS_FLAG_INIDLE is set and
tick_nohz_irq_exit() has exactly the work to do there that it has for
the idle task. What it is not is confined to sched_ext - it reaches the
idle_inject() users, intel_powerclamp and cpuidle_cooling - and v2 says
so rather than leaving that for a reviewer to find.

Writing it up also showed that my claim the new gate is "strictly wider"
than the old one is wrong, so it is gone. PF_IDLE is set by
cpu_startup_entry() and not by init_idle(), so a CPU on its idle task
before that point satisfies idle_cpu() but not is_idle_task(current).
Nothing is lost there, since TS_FLAG_INIDLE is only set inside do_idle()
and so tick_nohz_irq_exit() had nothing to do, and nohz_full CPUs are
covered by tick_nohz_full_cpu(cpu) either way. But the gates overlap
rather than one containing the other, and v2 states that instead.

Patch 1 is dropped from v2 at Tejun's request; the reproducer stays in
the archive and the fix links to it.

Disclosure: this reply was written by Claude Opus 5 (Claude Code) and
sent on my behalf, in the same session as the patch; the patch changelog
carries the same note.
