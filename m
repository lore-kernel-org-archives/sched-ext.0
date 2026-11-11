Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414697;
	b=dgLWNtvgEJEcn0yKOWrNBNvmksGBnoAqctnfoC4YCw4JKFW8ONzQW8jeChKBYWlWtEwu
	 JSmqZ2jZR72uQJgTImi1nJxLfBOkYOu42bRf7dytVt0X/y0cgb9wvBekg4Mx9WKwbDIJG
	 +PV3WY2u7cS3btixq5xT8+6TYuQQzJgr2iovMg/oihdB8JijOyDukx/UY75bR3ACXDnV8
	 Zhk0YCfO8Wy0ZukZEeq9Nqp9DFvHfZ4cd3k66RgBHym2vSWaSdaPrnb3v8sj+NcixAGr5
	 jzKx0EY2uNwIroi4HTqvgkUpfEw90L/cG+uPDEfHnL4WJ93Xg4WPwDeq2s9dH4mnGeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414697;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=APZI7CiU6LomQhDhdPfDm5AIR0g7StSMHorYfLj9NFI=;
	b=1aIoeHjP0kF2pYo3mjjKha0LfSjGyv9591BKad/UrLZyqIVNPqsHtXHP2wo3Zi46UGPk
	 gLuDgDXFfolpz1hSwXVmfXbFFwq3nTSjF5o4Nq2SkLQKtido8OpagL9rHoW+Beq9IZfHs
	 5THOyZDTAKYBoy85k1GgIsb8PfVCU5kH9mlUmrmZj9O34H5XOor1FqwOGW9NHaIXKVQBG
	 4zA9jmp8M/f8YUFZQRWFYDNvcDxL+xUdCwdQiezyFCBSeo699GeMFIXnVoF0bpF2Hqe1T
	 lLmqZ3bBhVGddLaJ9q6CZhPMhF3Rwez9GL53RIbQsT3DtVBPgggvrbWk/NmHQ1fVZLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MjJKuKR8;
	arc=none smtp.remote-ip=95.215.58.163
Received: from mta1.migadu.com (out-163.mta1.migadu.com [95.215.58.163])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AED9606A321
	for <sched-ext@lists.linux.dev>; Wed, 11 Nov 2026 16:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AED9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MjJKuKR8
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=APZI7CiU6LomQhDhdPfDm5AIR0g7StSMHorYfLj9NFI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794414694; v=1; x=1795019494;
 b=MjJKuKR8AA2qE80ni2BQOis510+8i8823B8WV9JsRvMixHdGn+FU+Nkn0s878izMiEfRkSaB
 K+JLhrE5VEgZ7VhzDEiOF9kYl/FWNi+XJe/R8hkHvJMMl3SUj+cPrLJjjXlPv73K4UwI7DJsdLy
 6+loOYentyuGsWIocRNq6Ogs=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 4647fe6a3e7ecebd;
	Wed, 11 Nov 2026 16:31:33 +0000
X-Mizu-Trace-ID: 4647fe6a3e7ecebd
X-Migadu-Flow: FLOW_OUT
Date: Wed, 11 Nov 2026 16:31:31 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: radu.m.toader@gmail.com
CC: anna-maria@linutronix.de, arighi@nvidia.com, bigeasy@linutronix.de,
 boqun@kernel.org, bpf@vger.kernel.org, brads@mainlining.org, brho@google.com,
 bsegall@google.com, changwoo@igalia.com, dietmar.eggemann@arm.com,
 enlin.mu@linux.dev, frederic@kernel.org, haoluo@google.com,
 joelagnelf@nvidia.com, joshdon@google.com, juri.lelli@redhat.com,
 kmehltretter@gmail.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 mgorman@suse.de, mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
 sched-ext@lists.linux.dev, tglx@kernel.org, tglx@linutronix.de,
 tj@kernel.org, vincent.guittot@linaro.org, void@manifault.com,
 vschneid@redhat.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_softirq=3A_Treat_an_interru?=
 =?US-ASCII?Q?pted_idle_task_as_idle_in_tick=5Firq=5Fexit=28=29?=
Message-ID: <19FFF394-CD37-43DF-BCEE-594179867434@linux.dev>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Wow, the changelog is huge! Could you please shorten things down?

Other than that

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>

--- Thanks!
