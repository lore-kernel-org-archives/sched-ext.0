Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D20368D6B;
	Sun, 16 Aug 2026 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786839089; cv=none; b=aNhnU4nSdvm+5u3z+bzRnwSesf8+0AJSXyxup/rlGlmoLJtiiQffQ8fpha2hJuXqNt+yfIEAQFL7C0PAaw45p3HiuReLW3oAXJaUY2bRlfJf8KLgsFuyqXdCRy9iJlsHlnlPxtE248S5gxivPvOVtGjdjYfkxOr4ywSN0qHAveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786839089; c=relaxed/simple;
	bh=286DKP7EYWnggjEkXb9NUKoDBTmGKiRd8QyJHJItIKg=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=bMc2BjYhZ07E7I9jGYERM4csnQyyk4mctP4ZP/SgXZ2Dgp5JMYEote0VyfhVllW9ETNSOGiwfLF8euCfgG8BpcFTrKoHioxKnXaQ7PZmP8QqIWWn/byiXo1EZKTEaM3g0hX/NdwO19r6lFSN5EfKFabc7SNJNJhwOa/LIqGLTMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGLbnJ+p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGLbnJ+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B01E1F000E9;
	Sun, 16 Aug 2026 00:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786839086;
	bh=286DKP7EYWnggjEkXb9NUKoDBTmGKiRd8QyJHJItIKg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=SGLbnJ+paDv3/3YvoEuW1dFi9zFjctUaefsWXdB7gxj1vjM0fNOLccJIY11zS/yyg
	 QeGJKqpKe8pfRmUevY95gB75QcQm9a5JTzSpz1R+qWPhIYnNyTcEbrNPp95DEc+Ukz
	 mxehOOJ1grqmpUmi/1EnVU6Ih48wbk8+9kJWDpnleyNa92J2xk0SibTN07IYz23c8M
	 nvaccaE/mYILGsL+1ekIBVslkibYBiF1NRqYPTtnsHJKYgtRwL7bQnYw5otxrbPAKG
	 Yv9VxaJ0ABYpag68PypWgODnnq6xzOlLwglVaOCcin73A+zInULqmtg/dNhLblMp+g
	 iALJU/jOgARVw==
Date: Sat, 15 Aug 2026 14:11:25 -1000
Message-ID: <097b036b0f12f4475ebe36183ff77278@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1f50a8edb9b37d10adb80552b08f8636@kernel.org>
References: <1f50a8edb9b37d10adb80552b08f8636@kernel.org>
Subject: Re: [PATCH sched_ext/for-7.3] sched_ext: Move the config-off sub-cap kfunc stubs into sub.c
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3.

Thanks.

--
tejun
