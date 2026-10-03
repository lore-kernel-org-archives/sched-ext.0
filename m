Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B10E35B63C
	for <sched-ext@lists.linux.dev>; Sat,  3 Oct 2026 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791009487; cv=none; b=ZiQPlF0AhhAGDAI2GsChqdPaiHs4SsDD/vWd6u9RfsMjtw2bBN7pIU2EjIjySvXRnNbFxkCiQ4Oh+85JGx1CxG7zPkl5i4VBW1o/7/5aPVKD5lM03H12cMLBA4BZkh8tz4f/PGPlHvCnL+s8Vjvg5s02OPjZXfoQVMjDe5JkEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791009487; c=relaxed/simple;
	bh=w2CHf/Ruyl0ieMWiVy7QleNiafjxfD+l+EFZ1XXXNB8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=RTBVv+RrZEcVhXjDctZgewopeJLXj5kWV5rP2HNyrpNB97xNshmtgJSt5pDM4SS/Vch1MGkCneu/TA2uRpMoRW4fqDzgBtHBUukSytfWvIYLA6zXXESPY/wo1zBpzzfkQv8enXlmGZojdgvdhrO7lhkiz1HylcAjwoOjmOywEXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3qQrOgZ; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3qQrOgZ"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c3304784so48113a12.3
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 23:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791009484; x=1791614284; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rn5qy1uct3HxkhX0TLP/tcAeQOQET/L/4W2RbNiSgQ4=;
        b=j3qQrOgZEoz//Ca0huRUhCcIQ9lMBawoWYqo89ywHk6u3byGtsWKzoiq4yGsesD/kn
         EWGjtz+q7rH7ASSS9/kNYFaqktZyz5RbKKUBqLeHYAb59iP1QPGtsB0WJNQNmcquWb8N
         twdkr1RMOX6okLvnEfMNyjGXRO2fdddIQ1UGtQjoyZgf4JkblExQDeWFZ3QFHcRy3JPH
         wwMFjCfsUaBaUs12AgcNAwlYSIb5VdFR2fFAl/b68zGeT42N/ZJwwbyGQunVzMysN1g+
         czAGfyyxsLTdJIPIL3OBTwrUaVntOF/C13/fazDxalnf+4zfldNt9P+YO4R+3F5P7aka
         0tQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791009484; x=1791614284;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rn5qy1uct3HxkhX0TLP/tcAeQOQET/L/4W2RbNiSgQ4=;
        b=SH7RYdv/rlOxoPrfgPKKGO6u+Czbi2CcWQd9oNlSdXjn4pk+DyOaOoMH1jOa7SUF06
         TRBlEiz7c9oQm1HYBzCpkXyWxqJQsCHd4TOR506K5LdQ8FPzDfCfRYyNnyS99cEcTM+U
         SIkn0gBJIrGtiZRXmVztyvut78MnPM1ciBG/LmZYS8Y3wKrB2TgPcF7ghGmzIGastMtV
         1yipTeKK1XP4e+2ZaaWC4ZSZZgQvvvD86DrBpGxnYT5YErBxXiOr9b51+qVFH7rZo+GW
         930c/1T906XK/TJXcBrKT/NEkNC8NqvU0ROU0vneJezYgfohNchebsLb0rZmQafvuvmh
         5pGg==
X-Forwarded-Encrypted: i=1; AKwUvBwDHSMais7MKZcBWHNRVivKy/XsgQH0WYsaY7PJTUTU79IFBkFwTToBt3HHjWUecYFtuFz7GZIyr3o=@lists.linux.dev
X-Gm-Message-State: AFuF++lDv6qo2M5zCAhZc4bawINKkud941deKKz3STzhtcE2o5O7Wl9a
	EvH3HQ5A48vf1g/4dknlfGq9/i67y4+skxkPQFI+P0BCN7a+9iqpyWO8A00RwJF1ip0=
X-Gm-Gg: AYBFou37zm8MIo+ZRYk5DobYTV7Kxm/0v7G/76cpbFi2kjA1L0yPk6z9THzjTWtq9Vl
	GWMLpB6RuFHxM+iSsqOd8aYNDfSIIg7txku++07Kf0VEmaPXdy+sbf+PMRqJgCBxVcuo7AsTtsl
	pa7Y/B2IJGNTsJj8mW24xo1Hms7uDWaRBNG0G4RfdVTrUad8PQcAqVzaICvbB8cNNR1WQ/sVldM
	L1hcBxBln46CfAG13AHEI/cvCHw+DK0jwi/zamAMyj1bnVCojMO7vcGE1vC8+jLikAxLOxFclil
	ADsOxTyAmEqS8UGQiJ7MDzs+8z3IOkuO9r9DLuS4LaP6Y7PQhoy/RATaw0nChU34tHBihNh6nTA
	fjkpqMc0k321ViQWHOzaRfD20fa1fFw2usYQ+eaoByfTOKzEsk25dzWcTKFn+KSPVS9Hr2cNjO2
	eO6Rsg4iXtDWASAE0esZU8YnRJYirkiUWAlKXfkSoPkqFAhg2NTrNNNXQuNuS3RLhky++rnOwaL
	NtOvY1TxjVuHE2naJBVuURApO1WTIH3Ep3Ej5DHtDqX11HMBHDCv/Bd6cc6Qc7v7/SLenvZx8SF
	mHI=
X-Received: by 2002:a05:6a20:7495:b0:3e0:b778:d988 with SMTP id adf61e73a8af0-3e0bd4bff2bmr4998287637.83.1791009484332;
        Fri, 02 Oct 2026 23:38:04 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7370db1sm1809155a12.17.2026.10.02.23.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 23:38:03 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 06:38:02 +0000
Message-Id: <DLUZVHOLSN1B.115EUX4KJBEA3@gmail.com>
Cc: <alan.maguire@oracle.com>, <martin.lau@linux.dev>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <qmo@kernel.org>,
 <nathan@kernel.org>, <nsc@kernel.org>, <linux-kbuild@vger.kernel.org>,
 <linux@weissschuh.net>, <christian@heusel.eu>, <mcgrof@kernel.org>,
 <petr.pavlu@suse.com>, <samitolvanen@google.com>,
 <linux-modules@vger.kernel.org>, <rostedt@goodmis.org>,
 <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <acme@kernel.org>,
 <namhyung@kernel.org>, <irogers@google.com>,
 <linux-perf-users@vger.kernel.org>, <jikos@kernel.org>,
 <bentiss@kernel.org>, <linux-input@vger.kernel.org>, <tj@kernel.org>,
 <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>,
 <sched-ext@lists.linux.dev>, <shuah@kernel.org>,
 <linux-kselftest@vger.kernel.org>, <ojeda@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <arnd@arndb.de>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <abuehaze@amazon.com>, <doebel@amazon.de>, <mpohlack@amazon.de>,
 <jay.wang.upstream@gmail.com>
Subject: Re: [PATCH bpf-next v4 00/12] bpf: make the vmlinux BTF an
 on-demand loadable module (CONFIG_DEBUG_INFO_BTF=m) to save ~5.4 MB memory
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Jay Wang"
 <wanjay@amazon.com>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>
In-Reply-To: <44315425-c505-46fe-8379-f19d78ff3abb@linux.dev>
References: <596bfb65-db2d-413b-8039-c921031b50fd@linux.dev> <20261002073422.14253-1-wanjay@amazon.com> <44315425-c505-46fe-8379-f19d78ff3abb@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, Oct 02, 2026 at 01:58 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>      Keep zstd-compressed blob in the kernel image and decompress and
>      parse it synchronously on first use.

imo this is the only one of the three worth considering.
