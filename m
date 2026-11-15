Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774791;
	b=wKaP+kYh4s40ajgvIRit7XJW91lUwiRishot/d+LKguoXpP1gIiyZLME4X/+kjHqjtuD
	 rYnPcSJVScf3KSG1uCpcw1RCMSE8iu8vdyMj6ulyqfJIDKeb9DrrhzczQUX+wh1n/VaVQ
	 E9zaHi6yPjMrgQqGSjmvB1Tu7fVN/5Oul4IHvdflEptYl7ZboM64KrIUjQjGjzHT7tQdT
	 3ZOm+SPuH0BpR+O8bjfqmZvcCA+Ht5zXqsJDMmyYe8R2oxTUVOS9vCokqJFac2rTU+uPT
	 qvwGfm9xj6otbDJDhX7Vz6OXUVC3YwDLEmk+EZJ5ZNDniVf/9bq4AXC0811szs8XWPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774791;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=OL3gP810bqf0d17gNnBpCny/0hJkDJ4XH0dG+giXl44=;
	b=0OnFeTbRRKo5kqvDPqmPCJCx4DEmx1gRLMe2Kk/nK28omD6U+tpKYp5SBs9JIGoUjmmj
	 n6YzzC2R/3ciLAuw7f6MIaJw4bGFLBirEKvT9DHHKmMgTJHrVQMJ8f5R4y2cS8c70kmFr
	 5AQOJOxJqZz//7XNwv8XECP016K46cEoljVW/I9Q7qxeOnsswTShjR+MCV8eC1K7iNByt
	 FfGEa8L4+xIXXlAwR5TDq5OkKmhLucEDufTnCA2t+oSAlZf147R8Z2vNMTUnFENlacdPv
	 2KBkX3fiuA+Yom4d5q7NCiqc1dtcWdWQGGBDu4ksOVLw4IAc72z3Rdt/s9EMgBEcoYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lm71VFmk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AAD606A31F;
	Sun, 15 Nov 2026 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lm71VFmk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4031F000C4;
	Sun, 15 Nov 2026 20:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774791;
	bh=OL3gP810bqf0d17gNnBpCny/0hJkDJ4XH0dG+giXl44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Lm71VFmkhPUmWiJ7U1ZSkokJpmEp7i66ARFGrI686zEIWl5rsYDprS0TNnVrzJLEh
	 AA2tEQI6bjezK6ZI1zQquESZiRvhfkrZwQVQEJY6XTlbb1GvDMMLJxncWUMI+xzz4N
	 ngQKqXq2/cRusQA4/vzzjgarGpJFUBthtqahXkmGSBgFZpB2W1tR7HnASdxAPODXgf
	 FLVu5b+1C2HqxS0fpqgPbxHbc9o31GgTlhYhF9dllumeXImr4ckYKXgRd8uvv4UWgO
	 upT0C0VKGO0JrZAc/EHGNxQ9xMpLhMwWEJ1ykALB/osx05TxTsYPkGZ+4walgNehAu
	 lpllGY0Z0YSZg==
Date: Sun, 15 Nov 2026 10:33:10 -1000
Message-ID: <93d337b7c3b0267ea90a86b1ac9e5725@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
Cc: Jonathan Bastari Thamrin via B4 Relay <devnull+thamrinjonathan.gmail.com@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Emil Tsalapatis <emil@etsalapatis.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, sched-ext@lists.linux.dev, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Ihor Solodrai <ihor.solodrai@linux.dev>, Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: Re: [PATCH sched_ext for-7.4-fixes v3] selftests/sched_ext: Reduce rt_stall measurement noise
In-Reply-To: <20261116-scx-rt-stall-v3-1-8dd2d150c4aa@gmail.com>
References: <20261116-scx-rt-stall-v3-1-8dd2d150c4aa@gmail.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Applied to sched_ext/for-7.5 with the Fixes tag dropped.

Thanks.

--
tejun
